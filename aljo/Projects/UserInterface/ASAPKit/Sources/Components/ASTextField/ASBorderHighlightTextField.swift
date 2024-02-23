//
//  ASBorderHighlightTextField.swift
//  ASAPKit
//
//  Created by 이태영 on 2/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

public final class ASBorderHighlightTextField: UITextField {
  private let disposeBag = DisposeBag()
  private let inset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
  
  // MARK: - public
  public override var placeholder: String? {
    get { super.placeholder }
    set {
      attributedPlaceholder = NSAttributedString(
        string: newValue ?? "",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.disable]
      )
    }
  }
  
  // MARK: - init
  public init() {
    super.init(frame: .zero)
    font = .pretendard(.body3)
    textColor = .title
    layer.borderWidth = 1.5
    layer.borderColor = UIColor.gray02.cgColor
    layer.cornerRadius = 6
    bind()
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
  
  // MARK: - private method
  private func bind() {
    let endEditing = rx.controlEvent(.editingDidEnd)
    let beginEditing = rx.controlEvent(.editingDidBegin)
    
    Observable.merge(endEditing.asObservable(), beginEditing.asObservable())
      .map { [weak self] _ in
        self?.isFirstResponder == true ? UIColor.title : UIColor.gray02
      }
      .map(\.cgColor)
      .bind(to: layer.rx.borderColor)
      .disposed(by: disposeBag)
  }
}
