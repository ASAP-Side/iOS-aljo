//
//  ASRectButtonConfigurable.swift
//  ASAPKit
//
//  Created by 이태영 on 2/27/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

public protocol ASRectButtonConfigurable {
  var contentInsets: NSDirectionalEdgeInsets? { get set }
  
  var title: String? { get set }
  var titleColor: UIColor? { get set }
  var font: UIFont? { get set }
  var titleAlignment: UIButton.Configuration.TitleAlignment? { get set }
  
  var image: UIImage? { get set }
  var imagePlacement: NSDirectionalRectEdge? { get set }
  var imagePadding: ImagePaddingStyle? { get set }
  
  var backgroundColor: UIColor? { get set }
  var cornerRadius: CGFloat? { get set }
  var strokeWidth: CGFloat? { get set }
  var strokeColor: UIColor? { get set }
  
  var normalHandler: ((UIButton) -> Void)? { get set }
  var selectedHandler: ((UIButton) -> Void)? { get set }
  var disabledHandler: ((UIButton) -> Void)? { get set }
  var highlightedHandler: ((UIButton) -> Void)? { get set }
  
  func makeConfiguration() -> UIButton.Configuration
}

extension ASRectButtonConfigurable {
  public func makeConfiguration() -> UIButton.Configuration {
    var configuration = UIButton.Configuration.plain()
    if let contentInsets = contentInsets {
      configuration.contentInsets = contentInsets
    }
    
    configureTitle(at: &configuration)
    configureImage(at: &configuration)
    configureBackground(at: &configuration)
    
    return configuration
  }
  
  private func configureTitle(at configuration: inout UIButton.Configuration) {
    if let titleAlignment = titleAlignment {
      configuration.titleAlignment = titleAlignment
    }
    if let title = title {
      var titleContainer = AttributeContainer()
      titleContainer.font = font
      titleContainer.foregroundColor = titleColor
      configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
    }
  }
  
  private func configureImage(at configuration: inout UIButton.Configuration) {
    if let image = image {
      configuration.image = image
    }
    if let imagePlacement = imagePlacement {
      configuration.imagePlacement = imagePlacement
    }
    if case let .fixed(padding) = imagePadding {
      configuration.imagePadding = padding
    }
  }
  
  private func configureBackground(at configuration: inout UIButton.Configuration) {
    var backgroundCofiguration = UIBackgroundConfiguration.clear()
    
    if let backgroundColor = backgroundColor {
      backgroundCofiguration.backgroundColor = backgroundColor
    }
    if let cornerRadius = cornerRadius {
      backgroundCofiguration.cornerRadius = cornerRadius
    }
    if let strokeWidth = strokeWidth {
      backgroundCofiguration.strokeWidth = strokeWidth
    }
    if let strokeColor = strokeColor {
      backgroundCofiguration.strokeColor = strokeColor
    }
    
    configuration.background = backgroundCofiguration
  }
}

public enum ImagePaddingStyle {
  case fixed(padding: CGFloat)
  case dynamic
}
