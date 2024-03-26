//
//  AlertTransitionAnimator.swift
//  ASAPKit
//
//  Created by 이태영 on 3/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

final class AlertTransitionAnimator: NSObject {
  enum TransitionStyle {
    case presentation
    case dismissal
  }
  
  private let transitionStyle: TransitionStyle
  
  init(transitionStyle: TransitionStyle) {
    self.transitionStyle = transitionStyle
  }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension AlertTransitionAnimator: UIViewControllerAnimatedTransitioning {
  func transitionDuration(
    using transitionContext: UIViewControllerContextTransitioning?
  ) -> TimeInterval {
    return 0.4
  }
  
  func animateTransition(
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    switch transitionStyle {
    case .presentation:
      animatePresentation(transitionContext: transitionContext)
    case .dismissal:
      animateDismissal(transitionContext: transitionContext)
    }
  }
}

// MARK: - private method
extension AlertTransitionAnimator {
  private func animatePresentation(
    transitionContext: UIViewControllerContextTransitioning
  ) {
    let presentedView = transitionContext.view(forKey: .to)

    presentedView?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
    presentedView?.alpha = 0
    
    UIView.animate(
      withDuration: 0.4,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0,
      animations: {
        presentedView?.transform = .identity
        presentedView?.alpha = 1
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      })
  }
  
  private func animateDismissal(
    transitionContext: UIViewControllerContextTransitioning
  ) {
    let presentingView = transitionContext.view(forKey: .from)
    
    UIView.animate(
      withDuration: 0.4,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0,
      animations: {
        presentingView?.alpha = 0
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      })
  }
}
