//
//  IconModel.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit.UIImageAsset
import UIKit.UIImage

import ASAPKit

struct IconModel {
  let title: String
  let image: UIImage
  
  static func `default`() -> [Self] {
    return [
      UIImage.Icon.arrow_circle.toIconModel(to: "arrow_circle"),
      UIImage.Icon.arrow_down.toIconModel(to: "arrow_down"),
      UIImage.Icon.arrow_left.toIconModel(to: "arrow_left"),
      UIImage.Icon.arrow_right.toIconModel(to: "arrow_right"),
      UIImage.Icon.camera_black.toIconModel(to: "camera_black"),
      UIImage.Icon.camera_dark.toIconModel(to: "camera_dark"),
      UIImage.Icon.camera_gray.toIconModel(to: "camera_gray"),
      UIImage.Icon.picture_color.toIconModel(to: "picture_color"),
      UIImage.Icon.picture_gray.toIconModel(to: "picture_gray"),
      UIImage.Icon.minus.toIconModel(to: "minus"),
      UIImage.Icon.plus.toIconModel(to: "plus"),
      UIImage.Icon.push.toIconModel(to: "push"),
      UIImage.Icon.scope.toIconModel(to: "scope"),
      UIImage.Icon.xmark_circle.toIconModel(to: "xmark_circle"),
      UIImage.Icon.xmark_black.toIconModel(to: "xmark_black")
    ]
  }
}
