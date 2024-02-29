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
    thumbTintColor = .clear
  }
  
  private func createTrackLabel() {
    maximumValueImage = .Icon.sound
    minimumValueImage = .Icon.mute
  }
  
  private func createBaseLayer() {
    baseLayer.masksToBounds = true
    baseLayer.backgroundColor = UIColor.gray03.cgColor
    if let size = minimumValueImage?.size {
      baseLayer.frame = .init(
        x: size.width + 16,
        y: size.height / 2,
        width: frame.width - size.width * 2 - 32,
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
    trackLayer.frame = baseFrame
    layer.insertSublayer(trackLayer, at: 1)
  }
}
