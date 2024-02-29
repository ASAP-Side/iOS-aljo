//
//  UILabel + Extension.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

extension UILabel {
  func setTextWithStyle(
    to text: String?,
    with style: UIFont.PretendardStyle,
    additionalSetting: ((inout NSMutableParagraphStyle) -> Void)? = nil
  ) {
    guard let text = text else { return }
    
    var paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = style.lineHeight
    paragraphStyle.minimumLineHeight = style.lineHeight
    paragraphStyle.lineBreakMode = .byTruncatingTail
    
    additionalSetting?(&paragraphStyle)
    
    let attributes: [NSAttributedString.Key: Any] = [
      .paragraphStyle: paragraphStyle,
      .font: UIFont.pretendard(style) as Any,
      .kern: -0.02,
      .baselineOffset: (style.lineHeight - font.lineHeight) / 4
    ]
    
    let attributeString = NSAttributedString(string: text, attributes: attributes)
    self.attributedText = attributeString
  }
}
