//
//  ASTextFieldDemoController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASTextFieldDemoController: ComponentViewController {
  private let underBarTextField: ASUnderBarTextField = {
    let textField = ASUnderBarTextField()
    textField.descriptionText = "내용 입력 공간입니다."
    textField.maxTextCount = 8
    textField.placeHolder = "내용을 입력해주세요."
    textField.titleText = "닉네임"
    textField.isTextCountLabelHidden = false
    return textField
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: underBarTextField) {
      $0.top.equalToSuperview().offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
  }
}
