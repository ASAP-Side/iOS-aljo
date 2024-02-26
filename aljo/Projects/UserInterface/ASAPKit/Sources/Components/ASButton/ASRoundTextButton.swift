//
//  ASRoundTextButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import RxSwift

public final class ASRoundTextButton: RoundButton {
  public var title: String?
  public var titleColor: UIColor?
  public var selectedTitleColor: UIColor?
  public var selectedFont: UIFont?
  public var font: UIFont?
  
  public override func generateInitConfiguration() {
    super.generateInitConfiguration()
    
    configuration?.title = title
    configuration?.background.backgroundColor = baseBackgroundColor
    configuration?.baseForegroundColor = titleColor
    configuration?.background.strokeColor = baseBorderColor
    configuration?.automaticallyUpdateForSelection = true
    
    configurationUpdateHandler = updateRoundButton
  }
  
  private func updateRoundButton(with button: UIButton) {
    updateTitle(for: button.state == .selected)
    switch button.state {
      case .normal:
        button.configuration?.background.backgroundColor = baseBackgroundColor
        button.configuration?.baseForegroundColor = titleColor
        button.configuration?.background.strokeColor = baseBorderColor
      case .selected:
        button.configuration?.background.backgroundColor = selectedBackgroundColor
        button.configuration?.baseForegroundColor = selectedTitleColor
        button.configuration?.background.strokeColor = selectedBorderColor
        
      default:
        return
    }
  }
  
  private func updateTitle(for isSelected: Bool) {
    guard let title = title else { return }
    
    var container = AttributeContainer()
    container.font = (isSelected ? selectedFont ?? font : font)
    container.foregroundColor = (isSelected ? selectedTitleColor : titleColor)
    configuration?.attributedTitle = AttributedString(title, attributes: container)
  }
}
