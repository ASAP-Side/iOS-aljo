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
    button.baseBackgroundColor = .white
    button.selectedBackgroundColor = .red02
    
    button.baseBorderColor = .gray02
    button.selectedBorderColor = .red01
    
    button.titleColor = .title
    button.selectedTitleColor = .red01
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(button)
    
    button.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(50)
    }
    
    let action = UIAction { _ in
      self.button.isSelected.toggle()
    }
    button.addAction(action, for: .touchUpInside)
  }
}
