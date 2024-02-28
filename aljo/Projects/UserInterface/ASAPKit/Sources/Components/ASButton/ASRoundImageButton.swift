//
//  ASRounrImageButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public final class ASRoundImageButton: RoundButton {
  public var baseImage: UIImage?
  public var selectedImage: UIImage?
  
  public override func generateInitConfiguration() {
    super.generateInitConfiguration()
    
    configuration?.image = baseImage
    configuration?.automaticallyUpdateForSelection = false
    
    configurationUpdateHandler = updateState
  }
  
  private func updateState(with button: UIButton) {
    switch button.state {
      case .selected:
        button.configuration?.image = self.selectedImage
        button.configuration?.background.strokeColor = .clear
        button.configuration?.background.backgroundColor = self.selectedBackgroundColor ?? .clear
      case .normal:
        button.configuration?.image = self.baseImage
        button.configuration?.background.strokeColor = self.baseBorderColor ?? .clear
        button.configuration?.background.backgroundColor = .clear
      default:
        return
    }
  }
}
