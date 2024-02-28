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
      padding: ImagePaddingStyle,
      placement: NSDirectionalRectEdge,
      contentInset: NSDirectionalEdgeInsets
    )
    
    var contentInsets: NSDirectionalEdgeInsets? {
      switch self {
      case .fill:
        return .init(top: 14, leading: 0, bottom: 14, trailing: 0)
      case .stroke:
        return .init(top: 12, leading: 0, bottom: 12, trailing: 0)
      case .strokeImage:
        return .init(top: 12, leading: 0, bottom: 12, trailing: 0)
      }
    }
    
    var titleColor: UIColor? {
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
        return .pretendard(.body2)
      case .strokeImage:
        return .pretendard(.body2)
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
    
    var imagePadding: ImagePaddingStyle? {
      switch self {
      case .fill:
        return nil
      case .stroke:
        return nil
      case .strokeImage(let padding, _, _):
        return padding
      }
    }
    
    var backgroundColor: UIColor? {
      switch self {
      case .fill:
        return .red02
      case .stroke:
        return .clear
      case .strokeImage:
        return .clear
      }
    }
    
    var cornerRadius: CGFloat? {
      switch self {
      case .fill:
        return 10
      case .stroke:
        return 10
      case .strokeImage:
        return 10
      }
    }
    
    var strokeWidth: CGFloat? {
      switch self {
      case .fill:
        return nil
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
  }
}
