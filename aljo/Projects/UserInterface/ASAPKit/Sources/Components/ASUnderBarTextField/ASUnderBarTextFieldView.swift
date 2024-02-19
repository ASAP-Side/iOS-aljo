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

public final class ASUnderBarTextFieldView: UIStackView {
  private let disposeBag = DisposeBag()
  
  // MARK: - Components
  let textField: ASUnderBarTextField = {
    let textField = ASUnderBarTextField()
    textField.font = .pretendard(.body1)
    textField.clearButtonMode = .always
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
  
  // MARK: - Public
  public var isInputNegative: Bool = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  public var placeHolder: String? {
    get {
      textField.placeholder
    }
    
    set {
      textField.placeholder = newValue
    }
  }
  
  public var titleText: String? {
    get {
      titleLabel.text
    }
    
    set {
      titleLabel.text = newValue
      
      if newValue == nil {
        titleLabel.isHidden = true
      } else {
        titleLabel.isHidden = false
      }
    }
  }
  
  public var descriptionText: String? {
    get {
      descriptionLabel.text
    }
    
    set {
      descriptionLabel.text = newValue
      
      if newValue == nil {
        descriptionLabel.isHidden = true
      } else {
        descriptionLabel.isHidden = false
      }
    }
  }
  
  public var maxTextCount: Int {
    get {
      textField.maxTextCount
    }
    
    set {
      textField.maxTextCount = newValue
    }
  }
  
  public var text: String? {
    get {
      textField.text
    }
    
    set {
      textField.text = newValue
    }
  }
  
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
    configureStackView()
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
  private func configureStackView() {
    axis = .vertical
    alignment = .fill
    distribution = .fill
    spacing = 8
  }
  
  private func configureSubview() {
    [
      titleLabel,
      textField,
      underBar,
      descriptionLabel
    ].forEach {
      addArrangedSubview($0)
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
    
    Observable.from([endEditing, beginEditing])
      .merge()
      .subscribe(onNext: { [weak self] in
        self?.configureState()
      })
      .disposed(by: disposeBag)
  }
}
