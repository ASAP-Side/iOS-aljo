//
//  ASBottomSheetPresentationController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/15/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import SnapKit

final class ASBottomSheetPresentationController: UIPresentationController {
  private let presentationYPoint: CGFloat
  private let blurView: UIView = {
    let view = UIView()
    view.backgroundColor = .black.withAlphaComponent(0.5)
    return view
  }()
  
  init(
    presentedViewController: UIViewController,
    presenting presentingViewController: UIViewController?,
    presentationYPoint: CGFloat
  ) {
    self.presentationYPoint = presentationYPoint
    super.init(
      presentedViewController: presentedViewController,
      presenting: presentingViewController
    )
  }
}

// MARK: - Life Cycle
extension ASBottomSheetPresentationController {
  override func presentationTransitionWillBegin() {
    configureUI()
    configureAction()
  }
  
  override func dismissalTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
        return
    }
    
    coordinator.animate(alongsideTransition: { [weak self] _ in
      self?.blurView.alpha = 0
    })
  }
}

// MARK: - Configure Action
extension ASBottomSheetPresentationController {
  private func configureAction() {
    let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(tapBlurView))
    blurView.addGestureRecognizer(tapGestrue)
  }
  
  @objc 
  private func tapBlurView() {
    presentedViewController.dismiss(animated: true)
  }
}

// MARK: - Configure UI
extension ASBottomSheetPresentationController {
  private func configureUI() {
    configureHirearchy()
    configureConstraints()
  }
  
  private func configureHirearchy() {
    guard let containerView = containerView,
          let presentedView = presentedView
    else {
      return
    }
    containerView.addSubview(presentedView)
    containerView.addSubview(blurView)
  }
  
  private func configureConstraints() {
    blurView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
