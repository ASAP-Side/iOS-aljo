//
//  AlertPresentationController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

final class AlertPresentationController: UIPresentationController {
  private let blurView: UIView = {
    let view = UIView()
    view.backgroundColor = .black01
    view.alpha = 0
    return view
  }()
}

// MARK: - Life Cycle
extension AlertPresentationController {
  override func presentationTransitionWillBegin() {
    configureUI()
    let coordinator = presentedViewController.transitionCoordinator
    coordinator?.animate { _ in
      self.blurView.alpha = 0.5
    }
  }
  
  override func dismissalTransitionWillBegin() {
    let coordinator = presentedViewController.transitionCoordinator
    coordinator?.animate { _ in
      self.blurView.alpha = 0
    }
  }
}

// MARK: - Configure UI
extension AlertPresentationController {
  private func configureUI() {
    configureHierarchy()
    configureConstraints()
  }
  
  @objc
  private func tap() {
    presentedViewController.dismiss(animated: true)
  }
  
  private func configureHierarchy() {
    containerView?.addSubview(blurView)
    containerView?.addSubview(presentedViewController.view)
  }
  
  private func configureConstraints() {
    blurView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    presentedViewController.view.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
}
