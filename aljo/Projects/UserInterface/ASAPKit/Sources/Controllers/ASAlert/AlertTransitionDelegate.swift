//
//  AlertTransitionDelegate.swift
//  ASAPKit
//
//  Created by 이태영 on 3/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

final class AlertTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return AlertTransitionAnimator(
      transitionStyle: .presentation
    )
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return AlertTransitionAnimator(
      transitionStyle: .dismissal
    )
  }
  
  func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController
  ) -> UIPresentationController? {
    return AlertPresentationController(
      presentedViewController: presented,
      presenting: presenting
    )
  }
}
