//
//  ASRoundButton.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

import RxSwift

class ASRoundButtonDemoController: ComponentViewController {
  private let textButton: RoundButton = {
    let button = RoundButton(style: .text)
    button.title = "월"
    return button
  }()
  
  private let imageButton: RoundButton = {
    let button = RoundButton(style: .image)
    button.image = .Icon.check.withTintColor(.gray02)
    button.selectedImage = .Icon.check.withTintColor(.red01)
    return button
  }()
  
  private let imageBorderButton: RoundButton = {
    let button = RoundButton(style: .imageBorder)
    button.selectedImage = .Icon.check_small.withTintColor(.white)
    return button
  }()
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    binding()
    
    addSampleView(to: imageBorderButton) {
      $0.center.equalToSuperview()
      $0.width.height.equalTo(20)
    }
    
    addSampleView(to: textButton) {
      $0.trailing.equalTo(self.imageBorderButton.snp.leading).offset(-20)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(40)
    }
    
    addSampleView(to: imageButton) {
      $0.leading.equalTo(self.imageBorderButton.snp.trailing).offset(20)
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(16)
    }
  }
}

private extension ASRoundButtonDemoController {
  func binding() {
    textButton.rx.tap
      .withUnretained(self)
      .asObservable()
      .bind { $0.0.textButton.isSelected.toggle() }
      .disposed(by: disposeBag)
    
    imageBorderButton.rx.tap
      .withUnretained(self)
      .bind { $0.0.imageBorderButton.isSelected.toggle() }
      .disposed(by: disposeBag)
    
    imageButton.rx.tap
      .withUnretained(self)
      .bind { $0.0.imageButton.isSelected.toggle() }
      .disposed(by: disposeBag)
  }
}
