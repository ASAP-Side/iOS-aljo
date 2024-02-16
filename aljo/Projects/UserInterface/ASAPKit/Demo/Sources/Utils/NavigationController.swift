//
//  NavigationController.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

class ASNavigationController: UINavigationController {
  private var backButtonImage: UIImage? {
    return UIImage.Icon.arrow_left
  }
  
  private var backButtonAppearance: UIBarButtonItemAppearance {
    let appearance = UIBarButtonItemAppearance()
    appearance.normal.titleTextAttributes = [
      .foregroundColor: UIColor.clear,
      .font: UIFont.systemFont(ofSize: .zero) as Any
    ]
    return appearance
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationAppearance()
  }
  
  private func setNavigationAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    appearance.shadowColor = .clear
    appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
    appearance.backButtonAppearance = backButtonAppearance
    
    navigationBar.standardAppearance = appearance
    navigationBar.compactAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
    navigationBar.isTranslucent = false
    navigationBar.tintColor = .title
  }
}
