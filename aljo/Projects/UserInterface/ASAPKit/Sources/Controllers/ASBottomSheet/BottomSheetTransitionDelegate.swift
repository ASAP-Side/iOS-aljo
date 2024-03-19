//
//  ASBottomSheetTransitionDelegate.swift
//  ASAPKit
//
//  Created by 이태영 on 3/15/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

final class BottomSheetTransitionDelegate: NSObject {
  private let detent: ASBottomSheetDetent
  
  init(detent: ASBottomSheetDetent) {
    self.detent = detent
  }
}

extension BottomSheetTransitionDelegate: UIViewControllerTransitioningDelegate {
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return BottomSheetTransitionAnimator(
      transitionStyle: .presentation,
      ratio: detent.ratio
    )
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return BottomSheetTransitionAnimator(
      transitionStyle: .dismissal,
      ratio: detent.ratio
    )
  }
  
  func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController
  ) -> UIPresentationController? {
    return BottomSheetPresentationController(
      presentedViewController: presented,
      presenting: presenting
    )
  }
}
