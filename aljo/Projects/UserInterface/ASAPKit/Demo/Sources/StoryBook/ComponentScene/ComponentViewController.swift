//
//  ComponentViewController.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

import ASAPKit

class ComponentViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
  }
  
  func addSampleView(to subView: UIView, makeConstraints: @escaping (ConstraintMaker) -> Void) {
    self.view.addSubview(subView)
    subView.snp.makeConstraints(makeConstraints)
  }
}
