//
//  GroupCreateAlertViewController.swift
//  ASAPKitDemo
//
//  Created by 이태영 on 3/19/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

import ASAPKit

import SnapKit

final class GroupCreateAlertViewController: ASAlertController {
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = .Icon.party_popper
    return imageView
  }()
  
  private let button: UIButton = {
    let button = ASRectButton(style: .fill)
    button.title = "확인"
    return button
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.headLine3)
    label.text = "그룹 생성 완료!"
    label.textColor = .black01
    return label
  }()
  
  private let messageLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.body6)
    label.text = "6시간 후부터 알람이 울려요"
    label.textColor = .black02
    return label
  }()
  
  override func viewDidLoad() {
    configureUI()
    configureAction()
  }
}

// MARK: Configure Action
extension GroupCreateAlertViewController {
  private func configureAction() {
    let action = UIAction { [weak self] _ in
      self?.dismiss(animated: true)
    }
    
    button.addAction(action, for: .touchUpInside)
  }
}

// MARK: Configure UI
extension GroupCreateAlertViewController {
  private func configureUI() {
    configureHierarchy()
    configureConstraints()
    view.backgroundColor = .systemBackground
    view.clipsToBounds = false
    view.layer.cornerRadius = 20
  }
  
  private func configureHierarchy() {
    [imageView, button, titleLabel, messageLabel].forEach {
      view.addSubview($0)
    }
  }
  
  private func configureConstraints() {
    view.snp.makeConstraints {
      $0.width.equalTo(300)
      $0.height.equalTo(206)
    }
    
    imageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(-50)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(messageLabel.snp.top).offset(-4)
    }
    
    messageLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
    button.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
  }
}
