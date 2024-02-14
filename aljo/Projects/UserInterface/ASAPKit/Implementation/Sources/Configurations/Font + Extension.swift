//
//  Font + Extension.swift
//  ASAPKitImplemenetation
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit.UIFont

public extension UIFont {
  enum TypoSize: Int {
    case extraLarge = 22
    case large = 20
    case medium = 18
    case regular = 16
    case small = 14
    case extraSmall = 12
  }
  
  enum TypoWeight: String {
    case bold = "Bold"
    case medium = "Medium"
    case regular = "Regular"
  }
  
  enum PretendardStyle {
    case headLine1
    case headLine2
    case headLine3
    case headLine4
    case headLine5
    
    case body1
    case body2
    case body3
    case body4
    
    case caption1
    case caption2
    case caption3
    
    var size: TypoSize {
      switch self {
        case .headLine1:
          return .extraLarge
        case .headLine2:
          return .large
        case .headLine3, .body1:
          return .medium
        case .headLine4, .body2:
          return .regular
        case .headLine5, .body3, .body4:
          return .small
        case .caption1, .caption2, .caption3:
          return .extraSmall
      }
    }
    
    var weight: TypoWeight {
      switch self {
        case .headLine1, .headLine2, .headLine3, .headLine4, .headLine5:
          return .bold
        case .body1, .body2, .body3, .caption1:
          return .medium
        case .body4, .caption2, .caption3:
          return .regular
      }
    }
  }
  
  static func pretendard(_ style: PretendardStyle) -> UIFont? {
    let size = CGFloat(style.size.rawValue)
    switch style.weight {
      case .bold:
        return ASAPKitImplemenetationFontFamily.Pretendard.bold.font(size: size)
      case .medium:
        return ASAPKitImplemenetationFontFamily.Pretendard.medium.font(size: size)
      case .regular:
        return ASAPKitImplemenetationFontFamily.Pretendard.regular.font(size: size)
    }
  }
}
