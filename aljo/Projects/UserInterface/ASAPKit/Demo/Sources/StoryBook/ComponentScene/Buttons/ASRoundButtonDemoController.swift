//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASRoundButtonDemoController: ComponentViewController {
  private let roundButton: ASRoundButton = {
    let button = ASRoundButton()
    button.setTitle("월", for: .normal)
    button.titleLabel?.font = .pretendard(.body3)
    button.setTitleColor(.black, for: .normal)
    button.layer.backgroundColor = UIColor.greenColor.cgColor
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(roundButton)
    
    roundButton.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.height.equalTo(30)
      $0.width.equalTo(roundButton.snp.height)
    }
  }
}
