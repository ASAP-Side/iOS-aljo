//
//  ASRectButtonConfiguration.swift
//  ASAPKit
//
//  Created by 이태영 on 2/28/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

public struct ASRectButtonConfiguration: ASRectButtonConfigurable {
  public var contentInsets: NSDirectionalEdgeInsets?
  
  public var title: String?
  public var titleColor: UIColor?
  public var font: UIFont?
  public var titleAlignment: UIButton.Configuration.TitleAlignment?
  
  public var image: UIImage?
  public var imagePlacement: NSDirectionalRectEdge?
  public var imagePadding: ImagePaddingStyle?
  
  public var backgroundColor: UIColor?
  public var cornerRadius: CGFloat?
  public var strokeWidth: CGFloat?
  public var strokeColor: UIColor?
  
  public var normalHandler: ((UIButton) -> Void)?
  public var selectedHandler: ((UIButton) -> Void)?
  public var disabledHandler: ((UIButton) -> Void)?
  public var highlightedHandler: ((UIButton) -> Void)?
  
  public init() { }
}
