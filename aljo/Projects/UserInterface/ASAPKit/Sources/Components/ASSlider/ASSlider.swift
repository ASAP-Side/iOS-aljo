//
//  ASSlider.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public final class ASSlider: UISlider {
  private let baseLayer = CALayer()
  private let trackLayer = CALayer()
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    clear()
    
    createTrackLabel()
    createBaseLayer()
    createTrackLayer()
  }
  
  private func clear() {
    tintColor = .clear
    maximumTrackTintColor = .clear
    backgroundColor = .clear
    thumbTintColor = .gray01
  }
  
  private func createTrackLabel() {
    maximumValueImage = .Icon.sound
    minimumValueImage = .Icon.mute
  }
  
  private func createBaseLayer() {
    baseLayer.masksToBounds = true
    baseLayer.backgroundColor = UIColor.gray03.cgColor
    if let minSize = minimumValueImage?.size, let maxSize = maximumValueImage?.size {
      baseLayer.frame = .init(
        x: minSize.width + 16,
        y: minSize.height / 2,
        width: frame.width - minSize.width - maxSize.width - 32,
        height: 4
      )
    }
    baseLayer.cornerRadius = min(baseLayer.frame.width, baseLayer.frame.height) / 2
    layer.insertSublayer(baseLayer, at: 0)
  }
  
  func createTrackLayer() {
    let color = UIColor.red01
    trackLayer.backgroundColor = color.cgColor
    let baseFrame = baseLayer.frame
    
    if let minSize = minimumValueImage?.size {
      trackLayer.frame = .init(
        x: minSize.width + 16,
        y: minSize.height / 2,
        width: .zero,
        height: 4
      )
    }
    trackLayer.cornerRadius = min(trackLayer.frame.width, trackLayer.frame.height) / 2
    layer.insertSublayer(trackLayer, at: 1)
  }
}
