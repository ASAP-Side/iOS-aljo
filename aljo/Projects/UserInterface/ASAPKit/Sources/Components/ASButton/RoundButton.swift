//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import RxSwift

public class RoundButton: UIButton {
  public var title: String?
  public var image: UIImage?
  public var selectedImage: UIImage?
  
  private let style: UIButton.Configuration.RoundStyle
  
  public init(style: UIButton.Configuration.RoundStyle) {
    self.style = style
    super.init(frame: .zero)
    self.configuration = UIButton.Configuration.round(with: style)
    
    switch style {
      case .text:
        configurationUpdateHandler = makeTextStyleUpdateHandler()
        configuration?.titleTextAttributesTransformer = .init(makeTextStyleHandler())
      case .image, .imageBorder:
        configurationUpdateHandler = makeImageStyleUpdateHandler()
    }
  }
  
  @available(*, unavailable, message: "스토리보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func makeImageStyleUpdateHandler() -> ((UIButton) -> Void) {
    return { [weak self] button in
      guard let self = self else { return }
      
      var configuration = button.configuration
      
      if button.state == .selected {
        configuration?.image = selectedImage
        configuration?.background.strokeColor = style.selectedBorderColor ?? .clear
        configuration?.background.backgroundColor = style.selectedBackgroundColor ?? .clear
        configuration?.background.strokeWidth = style.selectedStrokeWidth
      }
      
      if button.state == .normal {
        configuration?.image = image
        configuration?.background.strokeColor = style.borderColor ?? .clear
        configuration?.background.backgroundColor = style.backgroundColor ?? .clear
        configuration?.background.strokeWidth = 1
      }
      
      button.configuration = configuration
    }
  }
  private func makeTextStyleHandler() -> ((AttributeContainer) -> AttributeContainer) {
    return { [weak self] container in
      guard let self = self else { return container }
      var container = container
      container.font = (isSelected ? style.selectedFont : style.font)
      container.foregroundColor = (isSelected ? style.selectedTitleColor : style.titleColor)
      return container
    }
  }
  
  private func makeTextStyleUpdateHandler() -> ((UIButton) -> Void) {
    return { [weak self] button in
      guard let self = self else { return }
      
      var configuration = button.configuration
      
      if button.state == .selected {
        configuration?.background.backgroundColor = style.selectedBackgroundColor
        configuration?.background.strokeColor = style.selectedBorderColor
        configuration?.background.strokeWidth = style.selectedStrokeWidth
      }
      
      if button.state == .normal {
        configuration?.background.backgroundColor = style.backgroundColor
        configuration?.background.strokeColor = style.borderColor
        configuration?.background.strokeWidth = 1
        configuration?.title = title
      }
      
      button.configuration = configuration
    }
  }
}
