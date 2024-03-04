//
//  ASSlider.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public final class ASSlider: UISlider {
  public enum HeightSize: CGFloat {
    case small = 4
    case regular = 8
    case large = 16
  }
  
  private var height: HeightSize
  
  public init(height: HeightSize = .small) {
    self.height = height
    super.init(frame: .zero)
  }
  
  @available(*, unavailable, message: "스토리 보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public var leftTintColor: UIColor? {
    get { return tintColor }
    set { tintColor = newValue }
  }
  
  public var rightTintColor: UIColor? {
    get { return maximumTrackTintColor }
    set { maximumTrackTintColor = newValue }
  }
  
  public var thumbnailTintColor: UIColor? {
    get { return thumbTintColor }
    set { thumbTintColor = newValue }
  }
  
  public var backgroundTintColor: UIColor? {
    get { return backgroundColor }
    set { backgroundColor = newValue }
  }
  
  public var rightImage: UIImage? {
    get { return maximumValueImage }
    set { maximumValueImage = newValue }
  }
  
  public var leftImage: UIImage? {
    get { return minimumValueImage }
    set { minimumValueImage = newValue }
  }
  
  public override func trackRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.trackRect(forBounds: bounds)
    rect.size.height = self.height.rawValue
    return rect
  }
}
