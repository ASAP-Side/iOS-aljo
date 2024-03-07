//
//  HeaderBox.swift
//  ASAPKit
//
//  Created by 이태영 on 3/7/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import UIKit

final class HeaderBox: UIView {
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 8
    stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    stackView.isLayoutMarginsRelativeArrangement = true
    return stackView
  }()
  
  private let headerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black02
    label.font = .pretendard(.body5)
    return label
  }()
  
  private let contentView: UIView
  
  init(contentView: UIView, title: String?) {
    self.contentView = contentView
    super.init(frame: .zero)
    headerLabel.text = title
    configureUI()
  }
  
  @available(*, unavailable, message: "스토리 보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: UI Configuration
extension HeaderBox {
  private func configureUI() {
    configureHirearchy()
    configureConstraints()
  }
  
  private func configureHirearchy() {
    addSubview(stackView)
    
    [headerLabel, contentView].forEach {
      stackView.addArrangedSubview($0)
    }
  }
  
  private func configureConstraints() {
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
