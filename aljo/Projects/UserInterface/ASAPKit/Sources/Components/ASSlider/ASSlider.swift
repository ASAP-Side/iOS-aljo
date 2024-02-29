//
//  ASSlider.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public final class ASSlider: UISlider {
  private let trackLayer = CALayer()
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    clear()
    createTrack()
    
    createTrackLabel()
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
  
  private func createTrack() {
    trackLayer.masksToBounds = true
    trackLayer.backgroundColor = UIColor.gray03.cgColor
    trackLayer.frame = .init(x: .zero, y: frame.height / 4, width: frame.width, height: 4)
    trackLayer.cornerRadius = min(trackLayer.frame.width, trackLayer.frame.height) / 2
    layer.insertSublayer(trackLayer, at: 0)
  }
}
