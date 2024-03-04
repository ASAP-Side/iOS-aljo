//
//  ASStepperDemoController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/4/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import ASAPKit

import SnapKit

final class ASStepperDemoController: UIViewController {
  private let stepper = ASStepper()
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    
    stepper.currentValue = 5
    stepper.maximumValue = 8
    stepper.minimumValue = 1
    
    view.addSubview(stepper)
    
    stepper.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
}
