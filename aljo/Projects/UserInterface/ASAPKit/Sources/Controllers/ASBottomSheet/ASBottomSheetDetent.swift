//
//  ASBottomSheetDetent.swift
//  ASAPKit
//
//  Created by 이태영 on 3/18/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import Foundation

public enum ASBottomSheetDetent {
  case custom(_ ratio: CGFloat)
  
  var ratio: CGFloat {
    switch self {
    case .custom(let ratio):
      return ratio
    }
  }
}
