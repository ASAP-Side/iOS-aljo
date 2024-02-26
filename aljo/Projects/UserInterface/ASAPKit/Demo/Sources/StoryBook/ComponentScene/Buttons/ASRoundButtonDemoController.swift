//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASRoundButtonDemoController: ComponentViewController {
  private let button: ASRoundTextButton = {
    let button = ASRoundTextButton()
    button.title = "월"
    button.font = .pretendard(.body3)
    button.baseBackgroundColor = .white
    button.selectedBackgroundColor = .red02
    
    button.baseBorderColor = .gray02
    button.selectedBorderColor = .red01
    
    button.titleColor = .title
    button.selectedTitleColor = .red01
    return button
  }()
  
  private let imageButton: ASRoundImageButton = {
    let button = ASRoundImageButton()
    button.selectedImage = .Icon.check.withTintColor(.white)
    button.selectedBackgroundColor = .red01
    button.baseBorderColor = .gray03
    return button
  }()
  
  private let onlyImageButton: ASRoundImageButton = {
    let button = ASRoundImageButton()
    button.selectedImage = .Icon.check.withTintColor(.red01)
    button.baseImage = .Icon.check.withTintColor(.gray03)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(button)
    view.addSubview(imageButton)
    view.addSubview(onlyImageButton)
    
    button.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(50)
    }
    
    imageButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(button.snp.trailing).offset(8)
      $0.width.height.equalTo(30)
    }
    
    onlyImageButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(imageButton.snp.trailing).offset(8)
      $0.width.height.equalTo(30)
    }
    
    let action = UIAction { _ in
      self.button.isSelected.toggle()
    }
    let action2 = UIAction { _ in
      self.imageButton.isSelected.toggle()
    }
    let action3 = UIAction { _ in
      self.onlyImageButton.isSelected.toggle()
    }
    button.addAction(action, for: .touchUpInside)
    imageButton.addAction(action2, for: .touchUpInside)
    onlyImageButton.addAction(action3, for: .touchUpInside)
  }
}
