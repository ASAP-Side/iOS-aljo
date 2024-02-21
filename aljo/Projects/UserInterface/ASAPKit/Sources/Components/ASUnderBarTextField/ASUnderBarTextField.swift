//
//  ASUnderBarTextField.swift
//  ASAPKit
//
//  Created by 이태영 on 2/18/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ASUnderBarTextField: UITextField {
  enum Constant {
    static let rightViewOffset: CGFloat = 8
  }
  
  private let disposeBag = DisposeBag()
  private var clearButtonWidth: CGFloat {
    return rightViewRect(forBounds: bounds).width + Constant.rightViewOffset
  }
  
  // MARK: - components
  private let textCountLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.body4)
    label.textColor = .disable
    label.isHidden = true
    return label
  }()
  private let clearButton: UIButton = {
    let button = UIButton()
    button.setImage(.Icon.xmark_circle, for: .normal)
    return button
  }()
  
  // MARK: - public
  var maxTextCount: TextLimit = .unLimit {
    didSet {
      if case .limit = maxTextCount {
        configureTextCount(.zero)
      }
    }
  }
  
  var isTextCountLabelHidden: Bool {
    get { textCountLabel.isHidden }
    set {
      if case .limit = maxTextCount {
        textCountLabel.isHidden = newValue
        return
      }
      
      textCountLabel.isHidden = newValue
    }
  }
  
  // MARK: - initializer
  init() {
    super.init(frame: .zero)
    configureSubview()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - override
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    var editingRect = super.editingRect(forBounds: bounds)
    editingRect.size.width -= Constant.rightViewOffset
    
    if textCountLabel.isHidden == false {
      editingRect.size.width -= (textCountLabel.frame.width + Constant.rightViewOffset)
    }
    
    return editingRect
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.textRect(forBounds: bounds)
    textRect.size.width -= Constant.rightViewOffset
    
    if textCountLabel.isHidden == false {
      textRect.size.width -= (textCountLabel.frame.width + Constant.rightViewOffset)
    }
    
    return textRect
  }
  
  // MARK: - private method
  private func bind() {
    rx.text.orEmpty
      .scan("", accumulator: { [weak self] oldValue, newValue in
        guard let self = self else {
          return newValue
        }
        
        if case let .limit(count) = maxTextCount {
            return count >= newValue.count ? newValue : oldValue
        }
        
        return newValue
      })
      .subscribe(with: self, onNext: { object, text in
        object.configureTextCount(text.count)
        object.text = text
        
        if text.isEmpty == true {
          object.rightViewMode = .never
          object.updateTextCountLabelOffset(-Constant.rightViewOffset)
        } else if text.count == 1 {
          object.updateTextCountLabelOffset((-self.clearButtonWidth))
          object.rightViewMode = .whileEditing
        }
      })
      .disposed(by: disposeBag)
    
    rx.controlEvent(.editingDidBegin)
      .subscribe(with: self, onNext: { object, _ in
        if object.text?.isEmpty == true {
          object.rightViewMode = .never
        } else {
          object.updateTextCountLabelOffset((-self.clearButtonWidth))
        }
      })
      .disposed(by: disposeBag)
    
    rx.controlEvent(.editingDidEnd)
      .subscribe(with: self, onNext: { object, _ in
        object.updateTextCountLabelOffset(-Constant.rightViewOffset)
        object.rightViewMode = .never
      })
      .disposed(by: disposeBag)
    
    clearButton.rx.tap
      .subscribe(with: self, onNext: { object, _ in
        object.text = nil
        object.rightViewMode = .never
        object.updateTextCountLabelOffset(-Constant.rightViewOffset)
      })
      .disposed(by: disposeBag)
  }
  
  private func configureTextCount(_ textCount: Int) {
    textCountLabel.text = "\(textCount)/\(maxTextCount)"
  }
  
  private func updateTextCountLabelOffset(_ offset: CGFloat) {
    guard textCountLabel.isHidden == false else {
      return
    }
    
    self.textCountLabel.snp.updateConstraints {
      $0.trailing.equalToSuperview().inset(-offset)
    }
    
    UIView.animate(withDuration: 0.07) {
      self.layoutIfNeeded()
    }
  }
  
  private func configureSubview() {
    addSubview(textCountLabel)
    rightView = clearButton
    
    textCountLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-Constant.rightViewOffset)
    }
  }
}
