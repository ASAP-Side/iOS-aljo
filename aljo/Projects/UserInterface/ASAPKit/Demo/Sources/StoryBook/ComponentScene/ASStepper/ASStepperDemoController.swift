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
  private let stepper = ASStepper(
    currentValue: 0,
    maximumValue: 8,
    minimumValue: 1
  )
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    view.addSubview(stepper)
    
    stepper.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
}
