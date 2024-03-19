//
//  ASBottomSheetAnimator.swift
//  ASAPKit
//
//  Created by 이태영 on 3/15/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

final class BottomSheetTransitionAnimator: NSObject {
  enum TransitionStyle {
    case presentation
    case dismissal
  }
  
  private let transitionStyle: TransitionStyle
  private let ratio: CGFloat
  
  init(
    transitionStyle: TransitionStyle,
    ratio: CGFloat
  ) {
    self.transitionStyle = transitionStyle
    self.ratio = ratio
  }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension BottomSheetTransitionAnimator: UIViewControllerAnimatedTransitioning {
  func transitionDuration(
    using transitionContext: UIViewControllerContextTransitioning?
  ) -> TimeInterval {
    return 1
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
extension BottomSheetTransitionAnimator {
  private func animatePresentation(
    transitionContext: UIViewControllerContextTransitioning
  ) {
    let presentedView = transitionContext.view(forKey: .to)
    let containerMaxY = transitionContext.containerView.frame.maxY
    
    presentedView?.frame.origin.y = containerMaxY
    
    UIView.animate(
      withDuration: 0.4,
      delay: 0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 0,
      animations: {
        presentedView?.frame.origin.y = containerMaxY * self.ratio
      },
      completion: { complete in
        transitionContext.completeTransition(complete)
      })
  }
  
  private func animateDismissal(
    transitionContext: UIViewControllerContextTransitioning
  ) {
    
    let presentingView = transitionContext.view(forKey: .from)
    
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 0,
      animations: {
        presentingView?.frame.origin.y = transitionContext.containerView.frame.height
      },
      completion: { complete in
        transitionContext.completeTransition(complete)
      })
  }
}
