//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASRoundButtonDemoController: ComponentViewController {
  private let textButton: RoundButton = .titleButton(with: "월")
  private let imageButton: RoundButton = .imageButton(
    normal: .Icon.check.withTintColor(.gray02),
    selected: .Icon.check.withTintColor(.red01)
  )
  private let imageBorderButton: RoundButton = .imageBorderButton(
    selected: .Icon.check.withTintColor(.white)
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(textButton)
    view.addSubview(imageButton)
    view.addSubview(imageBorderButton)
    
    textButton.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(40)
    }
    
    imageButton.snp.makeConstraints {
      $0.top.equalTo(textButton.snp.bottom).offset(16)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(40)
    }
    
    imageBorderButton.snp.makeConstraints {
      $0.top.equalTo(imageButton.snp.bottom).offset(16)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(40)
    }
    
    let action = UIAction { _ in
      self.textButton.isSelected.toggle()
    }
    
    let action2 = UIAction { _ in
      self.imageButton.isSelected.toggle()
    }
    
    let action3 = UIAction { _ in
      self.imageBorderButton.isSelected.toggle()
    }
    
    textButton.addAction(action, for: .touchUpInside)
    imageButton.addAction(action2, for: .touchUpInside)
    imageBorderButton.addAction(action3, for: .touchUpInside)
  }
}
