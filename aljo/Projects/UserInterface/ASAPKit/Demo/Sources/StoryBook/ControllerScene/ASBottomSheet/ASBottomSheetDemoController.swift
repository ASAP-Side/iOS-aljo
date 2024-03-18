//
//  ASBottomSheetDemoController.swift
//  ASAPKit
//
//  Created by 이태영 on 3/15/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import ASAPKit

final class ASBottomSheetDemoController: UIViewController {
  private let passwordButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.title = "비밀번호 입력"
    let button = UIButton()
    button.configuration = config
    return button
  }()
  
  private let listButton: UIButton = {
    var config = UIButton.Configuration.plain()
    config.title = "리스트"
    let button = UIButton()
    button.configuration = config
    return button
  }()
  
  override func viewDidLoad() {
    configureUI()
    configureAction()
  }
}

// MARK: Configure Action
extension ASBottomSheetDemoController {
  private var passwordAction: UIAction {
    UIAction { [weak self] _ in
      guard let self = self else {
        return
      }
      
      let viewController = BottomSheetPasswordViewController(detent: .custom(0.6))
      present(viewController, animated: true)
    }
  }
  
  private var listAction: UIAction {
    UIAction { [weak self] _ in
      guard let self = self else {
        return
      }
      
      let contents: [BottomSheetListCellContent] = [
        BottomSheetListCellContent(
          image: .Icon.camera_gray,
          text: "사진찍기",
          action: {
            let viewController = ASTextFieldDemoController()
            self.present(viewController, animated: true)
          }),
        BottomSheetListCellContent(
          image: .Icon.picture_color,
          text: "앨범에서 선택하기",
          action: {
            let viewController = ASStepperDemoController()
            self.present(viewController, animated: true)
          })
      ]
      
      let viewController = BottomSheetListViewController(
        detent: .custom(0.65),
        contents: contents
      )
      present(viewController, animated: true)
    }
  }
  
  private func configureAction() {
    passwordButton.addAction(passwordAction, for: .touchUpInside)
    listButton.addAction(listAction, for: .touchUpInside)
  }
}

// MARK: Configure UI
extension ASBottomSheetDemoController {
  private func configureUI() {
    view.backgroundColor = .systemBackground
    configureHierarchy()
    configureConstraints()
  }
  
  private func configureHierarchy() {
    [passwordButton, listButton].forEach {
      view.addSubview($0)
    }
  }
  
  private func configureConstraints() {
    passwordButton.snp.makeConstraints {
      $0.centerY.equalToSuperview().offset(-50)
      $0.centerX.equalToSuperview()
    }
    
    listButton.snp.makeConstraints {
      $0.top.equalTo(passwordButton.snp.bottom).offset(8)
      $0.centerX.equalToSuperview()
    }
  }
}
