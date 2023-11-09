//
//  UIBaseViewController.swift
//  AJUIKit
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

final class UIBaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension UIBaseViewController {
  func pushNavigation(to controller: UIBaseViewController) {
    self.navigationController?.pushViewController(controller, animated: true)
  }
}
