//
//  ASRectButtonDemoController.swift
//  ASAPKit
//
//  Created by 이태영 on 2/29/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import ASAPKit
import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ASRectButtonDemoController: ComponentViewController {
  private let disposeBag = DisposeBag()
  
  private let fillButton: ASRectButton = {
    let button = ASRectButton(style: .fill)
    button.title = "버튼"
    return button
  }()
  
  private let strokeButton: ASRectButton = {
    let button = ASRectButton(style: .stroke)
    button.title = "버튼"
    return button
  }()
  
  private let strokeImageButton: ASRectButton = {
    let button = ASRectButton(
      style: .strokeImage(padding: .dynamic,
                          placement: .trailing,
                          contentInsets: .init(top: 22, leading: 20, bottom: 22, trailing: 20))
    )
    
    button.title = "버튼"
    button.image = .Icon.arrow_circle.withTintColor(.gray01)
    button.selectedImage = .Icon.arrow_circle.withTintColor(.red01)
    return button
  }()
  
  private let leftStrokeImageButton: ASRectButton = {
    let button = ASRectButton(
      style: .strokeImage(padding: .dynamic,
                          placement: .leading,
                          contentInsets: .init(top: 22, leading: 20, bottom: 22, trailing: 20))
    )
    
    button.title = "버튼"
    button.image = .Icon.arrow_circle.withTintColor(.gray01)
    button.selectedImage = .Icon.arrow_circle.withTintColor(.red01)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: fillButton) {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
    
    addSampleView(to: strokeImageButton) {
      $0.top.equalTo(self.fillButton.snp.bottom).offset(32)
      $0.horizontalEdges.equalTo(self.fillButton.snp.horizontalEdges)
    }
    
    addSampleView(to: leftStrokeImageButton) {
      $0.top.equalTo(self.strokeImageButton.snp.bottom).offset(32)
      $0.horizontalEdges.equalTo(self.strokeImageButton.snp.horizontalEdges)
    }
    
    addSampleView(to: strokeButton) {
      $0.top.equalTo(self.leftStrokeImageButton.snp.bottom).offset(32)
      $0.centerX.equalTo(self.leftStrokeImageButton)
      $0.width.equalTo(100)
    }
    
    bind()
  }
  
  private func bind() {
    fillButton.rx.tap
      .map { _ in false }
      .bind(to: fillButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    strokeImageButton.rx.tap
      .scan(false) { state, _ in
        return !state
      }
      .bind(to: strokeImageButton.rx.isSelected)
      .disposed(by: disposeBag)
    
    leftStrokeImageButton.rx.tap
      .scan(false) { state, _ in
        return !state
      }
      .bind(to: leftStrokeImageButton.rx.isSelected)
      .disposed(by: disposeBag)
    
    strokeButton.rx.tap
      .scan(false) { state, _ in
        return !state
      }
      .bind(to: strokeButton.rx.isSelected)
      .disposed(by: disposeBag)
  }
}
