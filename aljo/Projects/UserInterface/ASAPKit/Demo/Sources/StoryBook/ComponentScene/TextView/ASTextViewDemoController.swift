//
//  ASTextView.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

final class ASTextViewDemoController: ComponentViewController {
  private let textView: ASTextView = {
    let textView = ASTextView(placeholder: "입력해보세요.", maxLength: 50)
    textView.borderColor = .black04
    textView.isShowCount = true
    textView.backgroundColor = .systemBackground
    return textView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: textView) {
      $0.centerY.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(30)
      $0.height.equalTo(130)
    }
  }
}
