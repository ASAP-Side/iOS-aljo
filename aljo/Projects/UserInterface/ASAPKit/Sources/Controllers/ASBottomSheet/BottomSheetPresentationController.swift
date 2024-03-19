//
//  ASBottomSheetPresentationController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/15/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import SnapKit

// swiftlint:disable: type_name
final class BottomSheetPresentationController: UIPresentationController {
  private let blurView: UIView = {
    let view = UIView()
    view.backgroundColor = .black01
    view.alpha = 0
    return view
  }()
}

// MARK: - Life Cycle
extension BottomSheetPresentationController {
  override func presentationTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
      return
    }
    
    configureUI()
    configureAction()
    configureKeyboardObserver()
    
    coordinator.animate(alongsideTransition: { [weak self] _ in
      self?.blurView.alpha = 0.5
    })
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

// MARK: - Configure Observer
extension BottomSheetPresentationController {
  private func configureKeyboardObserver() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(willShowKeyboard),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(willHideKeyboard),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  @objc
  private func willShowKeyboard(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
    else {
      return
    }
    
    presentedView?.frame.origin.y -= keyboardFrame.cgRectValue.height
  }
  
  @objc
  private func willHideKeyboard(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
    else {
      return
    }
    
    presentedView?.frame.origin.y += keyboardFrame.cgRectValue.height
  }
}

// MARK: - Configure Action
extension BottomSheetPresentationController {
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
extension BottomSheetPresentationController {
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
    
    containerView.addSubview(blurView)
    containerView.addSubview(presentedView)
  }
  
  private func configureConstraints() {
    blurView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
