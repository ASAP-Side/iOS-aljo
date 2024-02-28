//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASRoundButtonDemoController: ComponentViewController {
  private let textButton: ASRoundTextButton = {
    let button = ASRoundTextButton()
    button.title = "월"
    button.font = .pretendard(.body3)
    button.selectedFont = .pretendard(.headLine6)
    
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
    button.baseImage = .Icon.check.withTintColor(.clear)
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
    [textButton, imageButton, onlyImageButton].forEach(view.addSubview)
    
    textButton.snp.makeConstraints {
      $0.width.equalTo(textButton.snp.height).multipliedBy(1).priority(.required)
      $0.centerY.equalToSuperview()
    }
    
    imageButton.snp.makeConstraints {
      $0.width.equalTo(imageButton.snp.height).multipliedBy(1).priority(.required)
      $0.leading.equalTo(textButton.snp.trailing).offset(30)
      $0.centerY.equalToSuperview()
    }
    
    let action = UIAction { [weak self] _ in
      self?.textButton.isSelected.toggle()
    }
    let action2 = UIAction { [weak self] _ in
      self?.imageButton.isSelected.toggle()
    }
    
    let action3 = UIAction { [weak self] _ in
      self?.onlyImageButton.isSelected.toggle()
    }
    
    textButton.addAction(action, for: .touchUpInside)
    imageButton.addAction(action2, for: .touchUpInside)
    onlyImageButton.addAction(action3, for: .touchUpInside)
  }
}
