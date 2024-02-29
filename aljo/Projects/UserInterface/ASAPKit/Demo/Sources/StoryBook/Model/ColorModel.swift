//
//  ColorModel.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit.UIImageAsset
import UIKit.UIImage

import ASAPKit

enum ColorModel: String, CaseIterable, CustomStringConvertible {
  case primary
  case basic
  case greyScale
  case system
  
  var description: String {
    return rawValue.uppercased()
  }
  
  var items: [ASAPColorModel] {
    switch self {
      case .primary:
        return [UIColor.red01.toDemoModel(to: "Red 1"), UIColor.red02.toDemoModel(to: "Red 2")]
      case .basic:
        return [
          UIColor.title.toDemoModel(to: "Title"),
          UIColor.body01.toDemoModel(to: "Body 1"),
          UIColor.body02.toDemoModel(to: "Body 2"),
          UIColor.disable.toDemoModel(to: "Disable")
        ]
      case .greyScale:
        return [
          UIColor.white.toDemoModel(to: "White"),
          UIColor.gray01.toDemoModel(to: "Gray 1"),
          UIColor.gray02.toDemoModel(to: "Gray 2"),
          UIColor.gray03.toDemoModel(to: "Gray 3"),
          UIColor.gray04.toDemoModel(to: "Gray 4")
        ]
      case .system:
        return [
          UIColor.redColor.toDemoModel(to: "Red"),
          UIColor.greenColor.toDemoModel(to: "Green"),
          UIColor.blueColor.toDemoModel(to: "Blue")
        ]
    }
  }
}

struct ASAPColorModel {
  let title: String
  let color: UIColor
}
