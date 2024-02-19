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
    static let noLimitCount: Int = 0
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
  var maxTextCount: Int = 0 {
    didSet {
      guard maxTextCount > Constant.noLimitCount else {
        return
      }
      
      configureTextCount(Constant.noLimitCount)
    }
  }
  
  var isTextCountLabelHidden: Bool {
    get {
      textCountLabel.isHidden
    }
    
    set {
      guard newValue != false || maxTextCount != Constant.noLimitCount else {
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
      .scan("", accumulator: { oldValue, newValue in
        guard self.maxTextCount != Constant.noLimitCount else {
          return newValue
        }
        
        return self.maxTextCount >= newValue.count ? newValue : oldValue
      })
      .subscribe(onNext: { [weak self] text in
        guard let self = self else {
          return
        }
        self.configureTextCount(text.count)
        self.text = text
        
        if text.isEmpty == true {
          rightViewMode = .never
          self.updateTextCountLabelOffset(-Constant.rightViewOffset)
        } else if text.count == 1 {
          self.updateTextCountLabelOffset((-self.clearButtonWidth))
          rightViewMode = .whileEditing
        }
      })
      .disposed(by: disposeBag)
    
    rx.controlEvent(.editingDidBegin)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else {
          return
        }
        
        if text?.isEmpty == true {
          rightViewMode = .never
        } else {
          self.updateTextCountLabelOffset((-self.clearButtonWidth))
        }
      })
      .disposed(by: disposeBag)
    
    rx.controlEvent(.editingDidEnd)
      .subscribe(onNext: { [weak self] _ in
        self?.updateTextCountLabelOffset(-Constant.rightViewOffset)
        self?.rightViewMode = .never
      })
      .disposed(by: disposeBag)
    
    clearButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.text = nil
        self?.rightViewMode = .never
        self?.updateTextCountLabelOffset(-Constant.rightViewOffset)
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
