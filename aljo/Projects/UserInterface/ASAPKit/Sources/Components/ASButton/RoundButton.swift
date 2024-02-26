//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import RxSwift

public class RoundButton: UIButton {
  public var titleColor: UIColor? {
    get { configuration?.baseForegroundColor }
    set { configuration?.baseForegroundColor = newValue }
  }
  
  public override var backgroundColor: UIColor? {
    get { configuration?.background.backgroundColor }
    set { configuration?.background.backgroundColor = newValue }
  }
  
  public var borderColor: UIColor? {
    get { configuration?.background.strokeColor }
    set { configuration?.background.strokeColor = newValue }
  }
  
  public var font: UIFont? {
    get { configuration?.attributedTitle?.font }
    set { configuration?.attributedTitle?.font = newValue }
  }
  
  public init() {
    super.init(frame: .zero)
    
    var configuration = UIButton.Configuration.plain()
    configuration.titleAlignment = .center
    configuration.background.strokeWidth = 1
    configuration.cornerStyle = .fixed
    
    self.configuration = configuration
    self.automaticallyUpdatesConfiguration = false
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
