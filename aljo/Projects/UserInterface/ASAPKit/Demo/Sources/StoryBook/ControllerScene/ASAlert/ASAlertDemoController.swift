//
//  ASAlertDemoController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import ASAPKit

import SnapKit

final class ASAlertDemoController: UIViewController {
  private let alertButton: UIButton = {
    var configuration = UIButton.Configuration.plain()
    configuration.title = "alert"
    let button = UIButton()
    button.configuration = configuration
    return button
  }()
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    view.addSubview(alertButton)
    
    alertButton.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
    let action = UIAction { [weak self] _ in
      guard let self = self else {
        return
      }
      
      let viewController = GroupCreateAlertViewController()
      self.present(viewController, animated: true)
    }
    
    alertButton.addAction(action, for: .touchUpInside)
  }
}
