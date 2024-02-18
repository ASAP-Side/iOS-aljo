//
//  UILabel + Extension.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

extension UILabel {
  func setTextWithStyle(to text: String?, with style: UIFont.PretendardStyle) {
    guard let text = text else { return }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = style.lineHeight
    paragraphStyle.minimumLineHeight = style.lineHeight
    paragraphStyle.lineBreakMode = .byTruncatingTail
    
    let attributes: [NSAttributedString.Key: Any] = [
      .paragraphStyle: paragraphStyle,
      .font: UIFont.pretendard(style) as Any,
      .baselineOffset: (style.lineHeight - font.lineHeight) / 4
    ]
    
    let attributeString = NSAttributedString(string: text, attributes: attributes)
    self.attributedText = attributeString
  }
}
