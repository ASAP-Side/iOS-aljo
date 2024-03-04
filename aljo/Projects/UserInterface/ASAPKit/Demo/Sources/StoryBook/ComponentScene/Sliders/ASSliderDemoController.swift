//
//  ASSliderDemoController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import RxSwift

import ASAPKit

class ASSliderDemoController: UIViewController {
  private let label: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.font = .pretendard(.body6)
    label.textAlignment = .center
    return label
  }()
  
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
    
    configureUI()
    
    binding()
  }
}

private extension ASSliderDemoController {
  func binding() {
    slider.rx.value.changed
      .asObservable()
      .compactMap { round($0 * 10) / 10.0 }
      .map { String($0) }
      .bind(to: label.rx.text)
      .disposed(by: disposeBag)
  }
}

private extension ASSliderDemoController {
  func configureUI() {
    view.backgroundColor = .systemBackground

    configureHierarchy()
    makeConstraints()
  }
  
  func configureHierarchy() {
    [label, slider].forEach(view.addSubview)
  }
  
  func makeConstraints() {
    label.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.centerX.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(16)
    }
    
    slider.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.horizontalEdges.equalToSuperview().inset(16)
    }
  }
}
