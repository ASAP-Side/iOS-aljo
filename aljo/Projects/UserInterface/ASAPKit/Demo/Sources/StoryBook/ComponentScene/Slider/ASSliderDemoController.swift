//
//  ASSliderDemoController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

import RxCocoa
import RxSwift

class ASSliderDemoController: ComponentViewController {
  private let slider: ASSlider = {
    let slider = ASSlider(height: .small)
    slider.backgroundTintColor = .clear
    slider.rightTintColor = .gray03
    slider.leftTintColor = .red01
    slider.rightImage = .Icon.sound
    slider.leftImage = .Icon.mute
    return slider
  }()
  
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: slider) {
      $0.center.equalToSuperview()
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
    
    binding()
  }
}

private extension ASSliderDemoController {
  func binding() {
    slider.rx.value.changed
      .asObservable()
      .compactMap { round($0 * 10) / 10.0 }
      .map { String($0) }
      .bind(to: navigationItem.rx.title)
      .disposed(by: disposeBag)
  }
}
