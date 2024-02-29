//
//  FontHeaderView.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

class FontHeaderView: UITableViewHeaderFooterView {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black01
    return label
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    configureUI()
    layer.backgroundColor = UIColor.clear.cgColor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(title: String) {
    titleLabel.setTextWithStyle(to: title, with: .headLine1) { paragraph in
      paragraph.alignment = .center
    }
  }
  
  private func configureUI() {
    contentView.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(8)
      $0.horizontalEdges.equalTo(contentView).inset(16)
      $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-8)
    }
  }
}
