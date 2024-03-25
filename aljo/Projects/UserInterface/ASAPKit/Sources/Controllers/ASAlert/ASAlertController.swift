//
//  ASAlertController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

open class ASAlertController: UIViewController {
  private let alertTransitionDelegate: AlertTransitionDelegate
  public init() {
    self.alertTransitionDelegate = AlertTransitionDelegate()
    super.init(nibName: nil, bundle: nil)
    transitioningDelegate = alertTransitionDelegate
    self.modalPresentationStyle = .custom
  }
  
  @available(*, unavailable, message: "스토리 보드로 생성할 수 없습니다.")
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
