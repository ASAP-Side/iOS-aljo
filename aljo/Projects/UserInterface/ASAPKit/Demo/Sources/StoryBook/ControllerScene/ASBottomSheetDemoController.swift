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
  private let button: UIButton = {
    let button = UIButton()
    var config = UIButton.Configuration.plain()
    config.title = "비밀번호 입력"
    button.configuration = config
    return button
  }()
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    
    let action = UIAction { [weak self] _ in
      guard let self = self else {
        return
      }
      
      let svc = SomeViewController(detent: .custom(0.65))
      present(svc, animated: true)
    }
    
    button.addAction(action, for: .touchUpInside)
    
    view.addSubview(button)
    button.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
}

final class SomeViewController: ASBottomSheetController {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "비공개 알람입니다.\n비밀번호를 입력해주세요"
    label.textColor = .black01
    label.font = .pretendard(.headLine3)
    label.numberOfLines = 0
    return label
  }()
  
  private let textField: ASUnderBarTextField = {
    let textField = ASUnderBarTextField()
    textField.placeHolder = "비밀번호 4자리를 입력해주세요"
    textField.isLabelVisible = false
    return textField
  }()
  
  private let cancelButton: ASRectButton = {
    let button = ASRectButton(style: .fill)
    button.title = "취소"
    return button
  }()
  
  private let joinButton: ASRectButton = {
    let button = ASRectButton(style: .fill)
    button.title = "참여하기"
    return button
  }()
  
  private let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 8
    return stackView
  }()
  
  private let totalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    return stackView
  }()
  
  override func viewDidLoad() {
    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = 20
    view.addSubview(totalStackView)
    [cancelButton, joinButton].forEach {
      buttonStackView.addArrangedSubview($0)
    }
    
    [titleLabel, textField, buttonStackView].forEach {
      totalStackView.addArrangedSubview($0)
    }
    
    totalStackView.setCustomSpacing(44, after: titleLabel)
    totalStackView.setCustomSpacing(58, after: textField)
    
    totalStackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(24)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    let action = UIAction { [weak self] _ in
      self?.dismiss(animated: true)
    }
    cancelButton.addAction(action, for: .touchUpInside)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
