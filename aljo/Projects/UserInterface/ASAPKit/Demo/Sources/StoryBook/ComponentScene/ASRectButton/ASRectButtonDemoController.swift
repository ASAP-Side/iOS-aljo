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


final class ASRectButtonDemoController: UIViewController {
  private let disposeBag = DisposeBag()
  
  private let fillButton = ASRectButton(style: .fill)
  private let strokeButton = ASRectButton(style: .stroke)
  private let strokeImageButton = ASRectButton(
    style: .strokeImage(
      padding: .dynamic,
      placement: .trailing,
      contentInsets: .init(top: 22, leading: 20, bottom: 22, trailing: 20)
    )
  )
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    [fillButton, strokeButton, strokeImageButton].forEach {
      view.addSubview($0)
    }
    fillButton.title = "타이틀"
    strokeButton.title = "타이틀"
    strokeImageButton.title = "타이틀"
    strokeImageButton.image = .Icon.arrow_circle
    strokeImageButton.selectedImage = .Icon.arrow_circle
    
    fillButton.snp.makeConstraints {
      $0.bottom.equalTo(strokeImageButton.snp.top).offset(-20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    strokeImageButton.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    strokeButton.snp.makeConstraints {
      $0.top.equalTo(strokeImageButton.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(101)
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
    
    strokeButton.rx.tap
      .scan(false) { state, _ in
        return !state
      }
      .bind(to: strokeButton.rx.isSelected)
      .disposed(by: disposeBag)
  }
}
