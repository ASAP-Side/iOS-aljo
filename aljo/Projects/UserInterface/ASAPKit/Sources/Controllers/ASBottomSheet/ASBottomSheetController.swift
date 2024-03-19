//
//  ASBottomSheetController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/18/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

open class ASBottomSheetController: UIViewController {
  private let bottomSheetDelegate: BottomSheetTransitionDelegate
  
  public init(detent: ASBottomSheetDetent) {
    self.bottomSheetDelegate = BottomSheetTransitionDelegate(detent: detent)
    super.init(nibName: nil, bundle: nil)
    self.transitioningDelegate = bottomSheetDelegate
    self.modalPresentationStyle = .custom
  }
  
  @available(*, unavailable, message: "스토리 보드로 생성할 수 없습니다.")
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
