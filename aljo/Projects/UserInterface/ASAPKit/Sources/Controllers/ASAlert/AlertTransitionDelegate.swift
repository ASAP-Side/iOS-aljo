//
//  AlertTransitionDelegate.swift
//  ASAPKit
//
//  Created by 이태영 on 3/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

public class AlertTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
  public func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return AlertTransitionAnimator(
      transitionStyle: .presentation
    )
  }
  
  public func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return AlertTransitionAnimator(
      transitionStyle: .dismissal
    )
  }
  
  public func presentationController(
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
