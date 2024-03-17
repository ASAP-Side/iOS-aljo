//
//  ASCalendarDemoController.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import ASAPKit

import RxSwift

import SnapKit

final class ASCalendarDemoController: ComponentViewController {
  private let pickerView = ASCalendarView()
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: pickerView) { [weak self] in
      guard let self = self else { return }
      
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    
    pickerView.rx.selectedDate
      .subscribe {
        print($0.element)
      }
      .disposed(by: disposeBag)
  }
}
