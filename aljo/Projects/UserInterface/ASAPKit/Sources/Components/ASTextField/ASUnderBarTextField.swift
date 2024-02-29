//
//  ASUnderBarTextFieldView.swift
//  ASAPKit
//
//  Created by 이태영 on 2/18/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

public final class ASUnderBarTextField: UIView {
  private let disposeBag = DisposeBag()
  private let isInputNegativeRelay = PublishRelay<Void>()
  
  // MARK: - Components
  let textField: UITextField = {
    let textField = UITextField()
    textField.font = .pretendard(.body1)
    textField.textColor = .black01
    return textField
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.caption2)
    return label
  }()
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.caption2)
    return label
  }()
  private let underBar: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.layer.cornerRadius = 3
    return view
  }()
  private let totalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    return stackView
  }()
  private let textFieldStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 10
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    return stackView
  }()
  private let textCountLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.body4)
    label.textColor = .black04
    label.isHidden = true
    return label
  }()
  private let clearButton: UIButton = {
    let button = UIButton()
    button.setImage(.Icon.xmark_circle, for: .normal)
    button.isHidden = true
    return button
  }()
  
  // MARK: - Public
  /// 입력값이 올바른지를 나타낼 때 사용합니다.
  ///
  /// 기본 값은 false 입니다. Bool값에 따라 underBar와 descriptionText의 색이 변경됩니다.
  public var isInputNegative: Bool = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  /// TextField의 text가 없는 경우 나타나는 placeHolder입니다.
  public var placeHolder: String? {
    get { textField.placeholder }
    set {
      textField.attributedPlaceholder = NSAttributedString(
        string: newValue ?? "",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black04]
      )
    }
  }
  
  /// TextField의 상단에 나타나는 title의 text입니다.
  public var titleText: String? {
    get { titleLabel.text }
    set {
      titleLabel.text = newValue
      titleLabel.isHidden = newValue == nil
    }
  }
  
  /// TextField의 하단에 나타나는 text입니다.
  public var descriptionText: String? {
    get { descriptionLabel.text }
    set {
      descriptionLabel.text = newValue
      descriptionLabel.isHidden = newValue == nil
    }
  }
  
  /// TextField에 입력 Text 제한사항입니다.
  ///
  /// 기본값은 0 입니다. 0은 텍스트 개수에 제한이 없습니다.
  public var maxTextCount: UInt = 0 {
    didSet {
      configureTextCountLabel(.zero)
    }
  }
  
  /// TextField에 입력된 text 입니다.
  public var text: String? {
    get { textField.text }
    set { textField.text = newValue }
  }
  
  /// TextField에 text 개수와 maxText 개수를 나타내는 label의 표시 유무를 나타낼 때 사용합니다.
  ///
  /// 기본값은 false 입니다.
  public var isTextCountLabelHidden: Bool {
    get { textCountLabel.isHidden }
    set { textCountLabel.isHidden = newValue }
  }
  
  // MARK: - init
  public init() {
    super.init(frame: .zero)
    configureUI()
    bind()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - override
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    configureState()
  }
}

// MARK: Bind Method
extension ASUnderBarTextField {
  private func bind() {
    let endEditing = textField.rx.controlEvent(.editingDidEnd)
    let beginEditing = textField.rx.controlEvent(.editingDidBegin)
    
    Observable.merge(endEditing.asObservable(), beginEditing.asObservable())
      .subscribe(onNext: configureState)
      .disposed(by: disposeBag)
    
    let editing = textField.rx.text.orEmpty
      .scan("", accumulator: { [weak self] oldValue, newValue in
        guard let self = self else {
          return newValue
        }
        
        guard self.maxTextCount != 0 else {
          return newValue
        }
        
        return newValue.count > self.maxTextCount ? oldValue : newValue
      })
    
    editing
      .bind(to: textField.rx.text)
      .disposed(by: disposeBag)
    
    editing
      .map(\.count)
      .subscribe(onNext: configureTextCountLabel)
      .disposed(by: disposeBag)
    
    Observable.merge(
      beginEditing.asObservable(),
      editing.map { _ in }.skip(1),
      endEditing.asObservable()
    )
    .withUnretained(self)
    .compactMap { object, _ in
      object.textField.text?.isEmpty
    }
    .subscribe(onNext: animateClearButtonHidden)
    .disposed(by: disposeBag)
    
    clearButton.rx.tap
      .subscribe(with: self, onNext: { object, _ in
        object.animateClearButtonHidden(true)
        object.textField.text = nil
      })
      .disposed(by: disposeBag)
  }
}

// MARK: Private Mehtod
extension ASUnderBarTextField {
  private func configureState() {
    guard textField.isFirstResponder else {
      underBar.backgroundColor = .gray01
      descriptionLabel.textColor = .black04
      return
    }
    
    if isInputNegative == true {
      underBar.backgroundColor = .redColor
      descriptionLabel.textColor = .redColor
    } else {
      underBar.backgroundColor = .black02
      descriptionLabel.textColor = .black03
    }
  }
  
  private func configureTextCountLabel(_ textCount: Int) {
    guard maxTextCount != 0 else {
      textCountLabel.isHidden = true
      return
    }
    
    textCountLabel.text = "\(textCount)/\(maxTextCount)"
  }
  
  private func animateClearButtonHidden(_ isHidden: Bool) {
    guard isHidden != clearButton.isHidden else {
      return
    }

    self.textFieldStack.layoutMargins.right = isHidden ? 10 : 1
    
    self.clearButton.isHidden = isHidden
    
    UIView.animate(withDuration: 0.1) {
      self.layoutIfNeeded()
    }
  }
}

// MARK: Configure UI
extension ASUnderBarTextField {
  private func configureUI() {
    configureHirachy()
    makeConstratins()
    titleText = nil
    descriptionText = nil
  }
  
  private func configureHirachy() {
    addSubview(totalStackView)
    
    [textField, textCountLabel, clearButton].forEach {
      textFieldStack.addArrangedSubview($0)
    }
    
    [
      titleLabel,
      textFieldStack,
      underBar,
      descriptionLabel
    ].forEach {
      totalStackView.addArrangedSubview($0)
    }

  }
  
  private func makeConstratins() {
    totalStackView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
    textCountLabel.setContentHuggingPriority(.required, for: .horizontal)
    clearButton.setContentHuggingPriority(.required, for: .horizontal)
    
    totalStackView.setCustomSpacing(6, after: titleLabel)
    totalStackView.setCustomSpacing(4, after: textFieldStack)
    totalStackView.setCustomSpacing(8, after: underBar)
    
    underBar.snp.makeConstraints {
      $0.height.equalTo(2)
    }
  }
}
