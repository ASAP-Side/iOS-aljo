//
//  ASCalendarDemoController.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import ASAPKit

import SnapKit

final class ASCalendarDemoController: ComponentViewController {
  private let pickerView = ASCalendarView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSampleView(to: pickerView) {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
  }
}
