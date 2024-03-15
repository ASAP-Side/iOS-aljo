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
    textField.descriptionText = "사용할 닉네임을 입력하세요."
    textField.isInputVerify = false
    textField.maxTextCount = 8
    textField.titleText = "닉네임"
    textField.placeHolder = "사용할 닉네임을 입력하세요."
    textField.isLabelVisible = true
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
    let text = underLineTextField.rx.text
    
    let isEmpty = text.map { $0?.isEmpty == true }
      
    let isVerify = text.withUnretained(self)
      .map { object, text in
        object.checkFormat(to: text)
      }
      
    let description = Observable.combineLatest(isEmpty, isVerify) { isEmpty, isVerify in
      return isEmpty ? "사용할 닉네임을 입력하세요." : isVerify ? "" : "한글과 영어만 입력할 수 있습니다."
    }
    
    let isError = Observable.merge(isEmpty, isVerify)
    
    isError
      .bind(to: underLineTextField.rx.isInputVerify)
      .disposed(by: disposeBag)
    
    description.withUnretained(self)
    .bind { owner, text in
      owner.underLineTextField.descriptionText = text
    }
    .disposed(by: disposeBag)
  }
  
  private func checkFormat(to text: String?) -> Bool {
    guard let text = text else { return false }
    
    if text.isEmpty == true { return true }
    
    return text.range(of: "^[a-zA-Z가-힣]+$", options: .regularExpression) != nil
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
