//
//  ASTextFieldDemoController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import RxSwift
import RxCocoa

import ASAPKit

class ASTextFieldDemoController: ComponentViewController {
  private let underLineTextField: ASUnderBarTextField = {
    let textField = ASUnderBarTextField()
    textField.descriptionText = "내용을 입력하세요."
    textField.isTextCountLabelHidden = false
    textField.maxTextCount = 8
    textField.titleText = "닉네임"
    textField.placeHolder = "사용할 닉네임을 입력하세요."
    return textField
  }()
  
  private let rectTextField: ASBorderHighlightTextField = {
    let textField = ASBorderHighlightTextField()
    textField.placeholder = "내용을 입력해주세요."
    return textField
  }()
  
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: underLineTextField) {
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.top.equalToSuperview().offset(16)
    }
    
    addSampleView(to: rectTextField) { [weak self] in
      guard let underLineTextField = self?.underLineTextField else { return }
      $0.top.equalTo(underLineTextField.snp.bottom).offset(32)
      $0.horizontalEdges.equalTo(underLineTextField)
    }
    
    binding()
  }
  
  private func binding() {
    underLineTextField.rx.textValue
      .map { $0?.isEmpty == true }
      .bind(to: underLineTextField.rx.isInputNegative)
      .disposed(by: disposeBag)
  }
}
