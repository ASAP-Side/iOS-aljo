//
//  ASTextFieldDemoController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: underLineTextField) {
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.top.equalToSuperview().offset(16)
    }
  }
}
