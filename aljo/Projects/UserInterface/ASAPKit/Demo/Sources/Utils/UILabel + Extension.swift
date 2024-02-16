//
//  UILabel + Extension.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

extension UILabel {
  func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
    guard let text = text else { return }
    
    let style = NSMutableParagraphStyle()
    style.maximumLineHeight = lineHeight
    style.minimumLineHeight = lineHeight
    style.lineBreakMode = .byTruncatingTail
    
    let attributes: [NSAttributedString.Key: Any] = [
      .paragraphStyle: style,
      .baselineOffset: (lineHeight - font.lineHeight) / 4
    ]
    
    let attributeString = NSAttributedString(string: text, attributes: attributes)
    self.attributedText = attributeString
  }
}
