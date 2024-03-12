//
//  ASBorderHighlightTextField.swift
//  ASAPKit
//
//  Created by 이태영 on 2/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

public final class ASBorderHighlightTextField: UITextField {
  private let inset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
  
  // MARK: - public
  public override var placeholder: String? {
    get { super.placeholder }
    set {
      attributedPlaceholder = NSAttributedString(
        string: newValue ?? "",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black04]
      )
    }
  }
  
  // MARK: - init
  public init() {
    super.init(frame: .zero)
    font = .pretendard(.body3)
    textColor = .black01
    delegate = self
    layer.borderWidth = 1.5
    layer.borderColor = UIColor.gray02.cgColor
    layer.cornerRadius = 6
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - override
  public override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: inset)
  }
  
  public override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: inset)
  }
}

// MARK: UITextField Delegate
extension ASBorderHighlightTextField: UITextFieldDelegate {
  public func textFieldDidEndEditing(_ textField: UITextField) {
    layer.borderColor = UIColor.gray02.cgColor
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    layer.borderColor = UIColor.black01.cgColor
  }
}
