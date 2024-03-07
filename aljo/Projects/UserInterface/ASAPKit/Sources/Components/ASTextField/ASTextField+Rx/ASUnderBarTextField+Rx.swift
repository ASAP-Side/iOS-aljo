//
//  ASUnderBarTextField+Rx+Rx.swift
//  ASAPKit
//
//  Created by 이태영 on 2/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import RxCocoa
import RxSwift

public extension Reactive where Base: ASUnderBarTextField {
  var text: ControlProperty<String?> {
    return base.textField.rx.text
  }
  
  var isInputNegative: Binder<Bool> {
    return Binder(self.base) { asUnderBarTextField, isInputNegative in
      asUnderBarTextField.isInputNegative = isInputNegative
    }
  }
}
