//
//  ASStepperDemoController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/4/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import ASAPKit

import RxSwift
import RxCocoa
import SnapKit

final class ASStepperDemoController: ComponentViewController {
  private let stepper = ASStepper(
    currentValue: 0,
    maximumValue: 5,
    minimumValue: 0
  )
  
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: stepper) {
      $0.centerX.centerY.equalToSuperview()
    }
    
    binding()
  }
  
  private func binding() {
    stepper.rx.value
      .map(\.description)
      .bind(to: navigationItem.rx.title)
      .disposed(by: disposeBag)
  }
}
