//
//  TypographyModel.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit.UIFont

enum TypographyModel: CaseIterable, CustomStringConvertible {
  case headline
  case body
  case caption
  
  var description: String {
    switch self {
      case .headline:
        return "HEADLINE"
      case .body:
        return "BODY"
      case .caption:
        return "CAPTION"
    }
  }
  
  var items: [UIFont.PretendardStyle] {
    switch self {
      case .headline:
        return [.headLine1, .headLine2, .headLine3, .headLine4, .headLine5]
      case .body:
        return [.body1, .body2, .body3, .body4]
      case .caption:
        return [.caption1, .caption2, .caption3]
    }
  }
}
