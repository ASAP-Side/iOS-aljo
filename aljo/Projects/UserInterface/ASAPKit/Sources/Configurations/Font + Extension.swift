//
//  Font + Extension.swift
//  ASAPKitImplemenetation
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit.UIFont

public extension UIFont {
  enum TypoWeight: String {
    case bold = "Bold"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
  }
  
  enum PretendardStyle: String {
    case headLine1
    case headLine2
    case headLine3
    case headLine4
    case headLine5
    case headLine6
    
    case body1
    case body2
    case body3
    case body4
    case body5
    case body6
    
    case caption1
    case caption2
    case caption3
    
    public var size: Int {
      switch self {
        case .headLine1:
          return 22
        case .headLine2:
          return 20
        case .headLine3, .body1:
          return 18
        case .headLine4, .headLine5, .body2:
          return 16
        case .headLine6, .body3, .body4:
          return 15
        case .body5, .body6:
          return 14
        case .caption1, .caption2:
          return 13
        case .caption3:
          return 11
      }
    }
    
    public var weight: TypoWeight {
      switch self {
        case .headLine1, .headLine2, .headLine3, .headLine4, .headLine6:
          return .bold
        case .headLine5:
          return .semiBold
        case .body1, .body2, .body3, .body5, .caption1:
          return .medium
        case .body4, .body6, .caption2, .caption3:
          return .regular
      }
    }
    
    public var lineHeight: CGFloat {
      switch self {
        case .headLine1:
          return 30
        case .headLine2:
          return 28
        case .headLine3, .body1:
          return 26
        case .headLine4, .headLine5, .headLine6, .body2, .body3, .body4:
          return 24
        case .body5, .body6:
          return 22
        case .caption1, .caption2:
          return 20
        case .caption3:
          return 17
      }
    }
  }
  
  static func pretendard(_ style: PretendardStyle) -> UIFont? {
    let size = CGFloat(style.size)
    switch style.weight {
      case .bold:
        return ASAPKitFontFamily.Pretendard.bold.font(size: size)
      case .semiBold:
        return ASAPKitFontFamily.Pretendard.semiBold.font(size: size)
      case .medium:
        return ASAPKitFontFamily.Pretendard.medium.font(size: size)
      case .regular:
        return ASAPKitFontFamily.Pretendard.regular.font(size: size)
    }
  }
}
