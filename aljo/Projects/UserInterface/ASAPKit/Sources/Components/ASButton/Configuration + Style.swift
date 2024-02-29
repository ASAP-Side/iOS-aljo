//
//  Configuration + Style.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii, 이태영 All rights reserved.

import UIKit

public extension UIButton.Configuration {
  enum ASRectStyle {
    case fill
    case stroke
    case strokeImage(
      padding: PaddingStyle,
      placement: NSDirectionalRectEdge,
      contentInsets: NSDirectionalEdgeInsets
    )

    var contentInsets: NSDirectionalEdgeInsets {
      switch self {
      case .fill:
        return .init(top: 14, leading: 0, bottom: 14, trailing: 0)
      case .stroke:
        return .init(top: 12, leading: 0, bottom: 12, trailing: 0)
      case .strokeImage(_, _, let contentInsets):
        return contentInsets
      }
    }
    
    var titleColor: UIColor {
      switch self {
      case .fill:
        return .white
      case .stroke:
        return .title
      case .strokeImage:
        return .title
      }
    }
  
    var font: UIFont? {
      switch self {
      case .fill:
        return .pretendard(.headLine5)
      case .stroke:
        return .pretendard(.body5)
      case .strokeImage:
        return .pretendard(.body3)
      }
    }
    
    var cornerRadius: CGFloat {
      switch self {
      case .fill:
        return 10
      case .stroke:
        return 6
      case .strokeImage:
        return 10
      }
    }
    
    var strokeWidth: CGFloat {
      switch self {
      case .fill:
        return 0
      case .stroke:
        return 1.5
      case .strokeImage:
        return 1.5
      }
    }
    
    var strokeColor: UIColor? {
      switch self {
      case .fill:
        return nil
      case .stroke:
        return .red02
      case .strokeImage:
        return .red02
      }
    }
    
    var imagePlacement: NSDirectionalRectEdge? {
      switch self {
      case .fill:
        return nil
      case .stroke:
        return nil
      case .strokeImage(_, let placement, _):
        return placement
      }
    }
    
    var imagePadding: PaddingStyle? {
      switch self {
      case .fill:
        return nil
      case .stroke:
        return nil
      case .strokeImage(let padding, _, _):
        return padding
      }
    }
  }
  
  static func rect(style: ASRectStyle) -> Self {
    var configuration = plain()
    configuration.contentInsets = style.contentInsets
    
    var backgroundConfiguration = UIBackgroundConfiguration.clear()
    backgroundConfiguration.strokeColor = style.strokeColor
    backgroundConfiguration.strokeWidth = style.strokeWidth
    backgroundConfiguration.cornerRadius = style.cornerRadius
    configuration.background = backgroundConfiguration
    
    return configuration
  }
}

public enum PaddingStyle {
  case fixed(padding: CGFloat)
  case dynamic
}
