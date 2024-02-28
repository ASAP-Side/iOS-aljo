//
//  Configuration + Style.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii, 이태영 All rights reserved.

import UIKit

/*
 - Round Button
  - imageBorder
  - image
  - text
 
 */

public extension UIButton.Configuration {
  enum RoundStyle {
    case text
    case image
    case imageBorder
    
    var titleColor: UIColor? {
      switch self {
        case .text:   return .title
        default:      return nil
      }
    }
    
    var selectedTitleColor: UIColor? {
      switch self {
        case .text:   return .red01
        default:      return nil
      }
    }
    
    var backgroundColor: UIColor? {
      switch self {
        case .text:   return .white
        default:      return .clear
      }
    }
    
    var selectedBackgroundColor: UIColor? {
      switch self {
        case .text:   return .red02
        default:      return nil
      }
    }
    
    var borderColor: UIColor? {
      switch self {
        case .text:            return .gray02
        case .imageBorder:    return .gray03
        default:              return nil
      }
    }
    
    var selectedBorderColor: UIColor? {
      switch self {
        case .text:      return .red01
        default:         return nil
      }
    }
    
    var font: UIFont? {
      switch self {
        case .text:     return .pretendard(.body3)
        default:        return nil
      }
    }
    
    var selectedFont: UIFont? {
      switch self {
        case .text:     return .pretendard(.headLine6)
        default:        return nil
      }
    }
  }
  
  static func round(with style: RoundStyle) -> Self {
    var configuration = Self.plain()
    configuration.titleAlignment = .center
    configuration.background.strokeWidth = 1
    configuration.cornerStyle = .capsule
    return configuration
  }
}
