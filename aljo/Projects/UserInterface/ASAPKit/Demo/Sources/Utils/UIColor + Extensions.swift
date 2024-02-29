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
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0
    
    return (NSString(format: "#%06x", rgb) as String).uppercased()
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
