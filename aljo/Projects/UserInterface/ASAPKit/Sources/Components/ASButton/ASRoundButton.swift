//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public class ASRoundButton: UIButton {
  public init() {
    super.init(frame: .zero)
  }
  
  @available(*, unavailable, message: "사용할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    layer.cornerRadius = max(rect.width, rect.height) / 2
  }
}
