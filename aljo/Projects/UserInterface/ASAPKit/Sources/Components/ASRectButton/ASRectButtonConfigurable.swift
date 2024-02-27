//
//  ASRectButtonConfigurable.swift
//  ASAPKit
//
//  Created by 이태영 on 2/27/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

protocol ASRectButtonConfigurable {
  var title: String? { get set }
  var titleAlignment: UIButton.Configuration.TitleAlignment { get set }
  var font: UIFont? { get set }
  
  var image: UIImage? { get set }
  var imagePlacement: NSDirectionalRectEdge { get set }
  var imagePadding: ImagePaddingStyle { get set }
  
  var cornerRadius: CGFloat? { get set }
  var strokeWidth: CGFloat { get set }
  
  var isNormalHandler: ((UIButton.Configuration) -> Void)? { get set }
  var isSelectedHandler: ((UIButton.Configuration) -> Void)? { get set }
  var isDisabledHandler: ((UIButton.Configuration) -> Void)? { get set }
  var isHighlightedHandler: ((UIButton.Configuration) -> Void)? { get set }
}

enum ImagePaddingStyle {
  case fixed(padding: Int)
  case dynamic
}
