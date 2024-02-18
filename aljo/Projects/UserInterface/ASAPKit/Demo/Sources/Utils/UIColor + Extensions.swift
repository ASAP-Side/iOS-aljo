//
//  UIColor + Extensions.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

extension UIColor {
  func toDemoModel(to title: String) -> ASAPColorModel {
    return .init(title: title, color: self)
  }
  
  func toHexStr() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    
    getRed(&r, green: &g, blue: &b, alpha: &a)
    
    let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
    
    return (NSString(format:"#%06x", rgb) as String).uppercased()
  }
}

extension UIImage {
  convenience init?(color: UIColor, size: CGSize = .init(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContext(rect.size)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
  
  func toIconModel(to title: String) -> IconModel {
    return .init(title: title, image: self)
  }
}
