//
//  ASBottomSheetDetent.swift
//  ASAPKit
//
//  Created by 이태영 on 3/18/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import Foundation

public enum ASBottomSheetDetent {
  case large
  case medium
  case small
  case custom(_ ratio: CGFloat)
  
  var ratio: CGFloat {
    switch self {
    case .large:
      return 0.2
    case .medium:
      return 0.5
    case .small:
      return 0.8
    case .custom(let ratio):
      return ratio
    }
  }
}
