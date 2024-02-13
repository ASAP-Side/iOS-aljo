//
//  DemoCategoryCell.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit
import ASAPKitImplemenetation

class DemoCategoryCell: UITableViewCell {
  static var identifier: String {
    return String(describing: Self.self)
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.headLine4)
    label.textColor = UIColor(named: "title")
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    accessoryType = .disclosureIndicator
    configureUI()
  }
  
  func bind(to type: CustomStringConvertible? = nil) {
    guard let type = type else { return }
    
    self.titleLabel.text = type.description
  }
   
  func configureUI() {
    contentView.addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8)
    ])
    
  }
}