//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASRoundButtonDemoController: ComponentViewController {
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = 10
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    view.addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
    }
  }
}
