//
//  DemoCategoryCell.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import ASAPKit

class DemoCategoryCell: UITableViewCell {
  static var identifier: String {
    return String(describing: Self.self)
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black01
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    accessoryType = .disclosureIndicator
    configureUI()
  }
  
  func bind(to type: Any? = nil) {
    guard let type = type as? CustomStringConvertible else { return }
    
    self.titleLabel.text = type.description
  }
   
  func configureUI() {
    contentView.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.bottom.equalToSuperview().offset(-8)
    }
  }
}
