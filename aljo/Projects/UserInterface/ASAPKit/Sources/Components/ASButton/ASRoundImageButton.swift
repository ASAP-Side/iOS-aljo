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
    
    configurationUpdateHandler = { [weak self] button in
      switch button.state {
        case .selected:
          button.configuration?.image = self?.selectedImage
          button.configuration?.background.strokeColor = .clear
          button.configuration?.background.backgroundColor = self?.selectedBackgroundColor
        case .normal:
          button.configuration?.image = self?.baseImage
          button.configuration?.background.strokeColor = self?.baseBorderColor
          button.configuration?.background.backgroundColor = .clear
        default:
          return
      }
    }
  }
}
