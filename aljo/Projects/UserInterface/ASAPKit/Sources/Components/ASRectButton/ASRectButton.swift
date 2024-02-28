//
//  ASRectButton.swift
//  ASAPKit
//
//  Created by 이태영 on 2/28/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

typealias ForegroundColorAttribute = AttributeScopes.UIKitAttributes.ForegroundColorAttribute
typealias FontAttribute = AttributeScopes.UIKitAttributes.FontAttribute

public final class ASRectButton: UIButton {
  public init(style: Configuration.ASRectStyle) {
    super.init(frame: .zero)
    
    configuration = Configuration.plain()
    configuration?.contentInsets = style.contentInsets
    configureTitleConfiguration(with: style)
    configureBackgroundConfiguration(with: style)
    
    switch style {
    case .fill:
      configurationUpdateHandler = fillStyleUpdatehandler
    case .stroke:
      configurationUpdateHandler = strokeStyleUpdatehandler
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureTitleConfiguration(with style: Configuration.ASRectStyle) {
    var titleContainer = AttributeContainer()
    titleContainer.font = style.font
    titleContainer.foregroundColor = style.titleColor
    configuration?.attributedTitle = AttributedString(style.title, attributes: titleContainer)
  }
  
  private func configureBackgroundConfiguration(with style: Configuration.ASRectStyle) {
    var backgroundConfiguration = UIBackgroundConfiguration.clear()
    backgroundConfiguration.strokeColor = style.strokeColor
    backgroundConfiguration.strokeWidth = style.strokeWidth
    backgroundConfiguration.cornerRadius = style.cornerRadius
    configuration?.background = backgroundConfiguration
  }
  
  private func fillStyleUpdatehandler(_ button: UIButton) {
    switch button.state {
    case .normal:
      configuration?.background.backgroundColor = .red01
      configuration?.attributedTitle?[ForegroundColorAttribute.self] = .white
    case .disabled:
      configuration?.background.backgroundColor = .gray02
      configuration?.attributedTitle?[ForegroundColorAttribute.self] = .disable
    default:
      break
    }
  }
  
  private func strokeStyleUpdatehandler(_ button: UIButton) {
    switch button.state {
    case .normal:
      configuration?.background.strokeColor = .gray02
      configuration?.background.backgroundColor = .white
      configuration?.attributedTitle?[FontAttribute.self] = .pretendard(.body3)
      configuration?.attributedTitle?[ForegroundColorAttribute.self] = .title
    case .selected:
      configuration?.background.strokeColor = .red01
      configuration?.background.backgroundColor = .red02
      configuration?.attributedTitle?[FontAttribute.self] = .pretendard(.headLine6)
      configuration?.attributedTitle?[ForegroundColorAttribute.self] = .red01
    default:
      break
    }
  }
}
