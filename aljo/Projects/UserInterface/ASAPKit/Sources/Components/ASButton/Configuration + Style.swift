//
//  Configuration + Style.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii, 이태영 All rights reserved.

import UIKit

public extension UIButton.Configuration {
  enum ASRectStyle {
    case fill(title: String)
    case stroke(title: String)

    var contentInsets: NSDirectionalEdgeInsets {
      switch self {
      case .fill:
        return .init(top: 14, leading: 0, bottom: 14, trailing: 0)
      case .stroke:
        return .init(top: 12, leading: 0, bottom: 12, trailing: 0)
      }
    }
    
    var title: String {
      switch self {
      case .fill(let title):
        return title
      case .stroke(let title):
        return title
      }
    }
    
    var titleColor: UIColor {
      switch self {
      case .fill:
        return .white
      case .stroke:
        return .title
      }
    }
  
    var font: UIFont? {
      switch self {
      case .fill:
        return .pretendard(.headLine5)
      case .stroke:
        return .pretendard(.body2)
      }
    }
    
    var cornerRadius: CGFloat {
      switch self {
      case .fill:
        return 10
      case .stroke:
        return 10
      }
    }
    
    var strokeWidth: CGFloat {
      switch self {
      case .fill:
        return 0
      case .stroke:
        return 1.5
      }
    }
    
    var strokeColor: UIColor? {
      switch self {
      case .fill:
        return nil
      case .stroke:
        return .red02
      }
    }
  }
}
