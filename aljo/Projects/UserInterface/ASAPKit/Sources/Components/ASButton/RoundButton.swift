//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import RxSwift

public class RoundButton: UIButton {
  public var baseBackgroundColor: UIColor?
  public var selectedBackgroundColor: UIColor?
  public var baseBorderColor: UIColor?
  public var selectedBorderColor: UIColor?
  public var selectedFont: UIFont?
  public var font: UIFont?
  
  public init() {
    super.init(frame: .zero)
    
    generateInitConfiguration()
  }
  
  public func generateInitConfiguration() {
    var configuration = UIButton.Configuration.filled()
    configuration.titleAlignment = .center
    configuration.background.strokeWidth = 1
    configuration.cornerStyle = .fixed
    configuration.baseForegroundColor = .black
    
    self.configuration = configuration
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  @available(*, unavailable, message: "사용할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    let maxValue = max(bounds.width, bounds.height)
    bounds.size = CGSize(width: maxValue, height: maxValue)
  }
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect.standardized)
    
    configuration?.background.cornerRadius = max(rect.width, rect.height) / 2
  }
}
