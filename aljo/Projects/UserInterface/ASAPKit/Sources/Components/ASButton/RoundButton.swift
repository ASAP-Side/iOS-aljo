//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import RxSwift

public class RoundButton: UIButton {
  public var title: String?
  public var image: String?
  
  private let style: UIButton.Configuration.RoundStyle
  
  public init(style: UIButton.Configuration.RoundStyle) {
    self.style = style
    super.init(frame: .zero)
    
    var configuration = UIButton.Configuration.round(with: style)
    self.configuration = configuration
    
    switch style {
      case .text:
        configurationUpdateHandler = updateShapeForTextStyle
      default:
        configurationUpdateHandler = nil
    }
  }
  
  @available(*, unavailable, message: "스토리보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func updateTitle(for isSelected: Bool) {
    guard let title = title else { return }
    
    var container = AttributeContainer()
    container.font = (isSelected ? style.selectedFont : style.font)
    container.foregroundColor = (isSelected ? style.selectedTitleColor : style.titleColor)
    configuration?.attributedTitle = AttributedString(title, attributes: container)
  }
  
  private func updateShapeForTextStyle(_ button: UIButton) {
    updateTitle(for: button.state == .selected)
    
    if button.state == .selected {
      configuration?.background.backgroundColor = style.selectedBackgroundColor
      configuration?.background.strokeColor = style.selectedBorderColor
      return
    }
    
    if button.state == .normal {
      configuration?.background.backgroundColor = style.backgroundColor
      configuration?.background.strokeColor = style.borderColor
      return
    }
    
    return
  }
}
