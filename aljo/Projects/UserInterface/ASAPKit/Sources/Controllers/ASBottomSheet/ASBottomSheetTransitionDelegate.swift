//
//  ASBottomSheetTransitionDelegate.swift
//  ASAPKit
//
//  Created by 이태영 on 3/15/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

public final class ASBottomSheetTransitionDelegate: NSObject {
  private let yPoint: CGFloat
  
  public init(yPoint: CGFloat) {
    self.yPoint = yPoint
  }
}

extension ASBottomSheetTransitionDelegate: UIViewControllerTransitioningDelegate {
  public func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return ASBottomSheetAnimator(
      transitionStyle: .presentation,
      transitionYPoint: yPoint
    )
  }
  
  public func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return ASBottomSheetAnimator(
      transitionStyle: .dismissal,
      transitionYPoint: yPoint
    )
  }
  
  public func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController
  ) -> UIPresentationController? {
    return ASBottomSheetPresentationController(
      presentedViewController: presented,
      presenting: presenting,
      presentationYPoint: yPoint
    )
  }
}
