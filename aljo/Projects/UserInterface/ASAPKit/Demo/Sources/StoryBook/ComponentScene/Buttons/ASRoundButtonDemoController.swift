//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASRoundButtonDemoController: ComponentViewController {
  private let textButton: RoundButton = {
    let button = RoundButton(style: .text)
    button.title = "월"
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(textButton)
    
    textButton.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(40)
    }
  }
}
