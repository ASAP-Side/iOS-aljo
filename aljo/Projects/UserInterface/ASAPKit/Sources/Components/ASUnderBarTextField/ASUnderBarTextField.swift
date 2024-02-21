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
  
  // MARK: - Components
  let textField: CountTextField = {
    let textField = CountTextField()
    textField.font = .pretendard(.body1)
    textField.rightViewMode = .whileEditing
    textField.textColor = .title
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
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 8
    return stackView
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
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.disable]
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
  /// 기본값은 .unLimit 입니다.
  public var maxTextCount: TextLimit {
    get { textField.maxTextCount }
    set { textField.maxTextCount = newValue }
  }
  
  /// TextField에 입력된 text 입니다.
  public var text: String? {
    get { textField.text }
    set { textField.text = newValue }
  }
  
  /// TextField에 text 개수와 maxText 개수를 나타내는 label의 표시 유무를 나타낼 때 사용합니다.
  ///
  /// 기본값은 true 입니다.
  public var isTextCountLabelHidden: Bool {
    get {
      textField.isTextCountLabelHidden
    }
    
    set {
      textField.isTextCountLabelHidden = newValue
    }
  }
  
  // MARK: - init
  public init() {
    super.init(frame: .zero)
    configureSubview()
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
  
  // MARK: - private method
  private func configureSubview() {
    addSubview(stackView)
    stackView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    [
      titleLabel,
      textField,
      underBar,
      descriptionLabel
    ].forEach {
      stackView.addArrangedSubview($0)
    }
    underBar.snp.makeConstraints {
      $0.height.equalTo(2)
    }
    
    titleText = nil
    descriptionText = nil
  }
  
  private func configureState() {
    if textField.isFirstResponder == false {
      underBar.backgroundColor = .gray01
      descriptionLabel.textColor = .disable
      return
    }
    
    if isInputNegative == true {
      underBar.backgroundColor = .redColor
      descriptionLabel.textColor = .redColor
    } else {
      underBar.backgroundColor = .body01
      descriptionLabel.textColor = .body02
    }
  }
  
  private func bind() {
    let endEditing = textField.rx.controlEvent(.editingDidEnd)
    let beginEditing = textField.rx.controlEvent(.editingDidBegin)
    
    Observable.merge(endEditing.asObservable(), beginEditing.asObservable())
      .subscribe(with: self, onNext: { object, _ in
        object.configureState()
      })
      .disposed(by: disposeBag)
  }
}
