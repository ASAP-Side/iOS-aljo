//
//  ASSlider.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public final class ASSlider: UISlider {
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    configureItems()
  }
  
  private func configureItems() {
    tintColor = .red01
    maximumTrackTintColor = .gray03
    backgroundColor = .clear
    thumbTintColor = .white
    
    maximumValueImage = .Icon.sound
    minimumValueImage = .Icon.mute
  }
  
  public override func trackRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.trackRect(forBounds: bounds)
    rect.size.height = 4
    return rect
  }
}
