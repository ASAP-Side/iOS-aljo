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
  private let disposeBag = DisposeBag()
  private var textCountLabelTrailingConstraint: Constraint?
  private var clearButtonWidth: CGFloat {
    return clearButtonRect(forBounds: bounds).width
  }
  
  // MARK: - components
  private let textCountLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.body4)
    label.textColor = .disable
    return label
  }()
  
  // MARK: - public
  var maxTextCount: Int = 0 {
    didSet {
      guard maxTextCount > 0 else {
        return
      }
      
      textCountLabel.isHidden = false
      configureTextCount(0)
    }
  }
  
  var isTextCountLabelHidden: Bool {
    get {
      textCountLabel.isHidden
    }
    
    set {
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
    return bounds
  }
  
  // MARK: - private method
  private func bind() {
    rx.text.orEmpty
      .scan("", accumulator: { oldValue, newValue in
        guard self.maxTextCount != 0 else {
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
        
        if text.count == 1 {
          updateTextCountLabelOffset((-clearButtonWidth - 10))
        } else if text.isEmpty {
          updateTextCountLabelOffset(-10)
        }
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
    
    UIView.animate(withDuration: 0.2) {
      self.layoutIfNeeded()
    }
  }
  
  private func configureSubview() {
    addSubview(textCountLabel)
    
    textCountLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      textCountLabelTrailingConstraint = $0.trailing.equalToSuperview().offset(-8).constraint
    }
  }
}
