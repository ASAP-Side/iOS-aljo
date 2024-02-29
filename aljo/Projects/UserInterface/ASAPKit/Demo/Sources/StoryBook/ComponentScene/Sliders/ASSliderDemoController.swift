//
//  ASSliderDemoController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class ASSliderDemoController: UIViewController {
  private let slider = ASSlider()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    view.addSubview(slider)
    
    slider.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(16)
    }
  }
}
