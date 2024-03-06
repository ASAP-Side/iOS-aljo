//
//  ASStepper+Rx.swift
//  ASAPKit
//
//  Created by 이태영 on 3/6/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: ASStepper {
  public var value: ControlProperty<Int> {
    return base.rx.controlProperty(
      editingEvents: .valueChanged,
      getter: { stepper in
        stepper.currentValue
      }, setter: { stepper, newValue in
        stepper.currentValue = newValue
      })
  }
}
