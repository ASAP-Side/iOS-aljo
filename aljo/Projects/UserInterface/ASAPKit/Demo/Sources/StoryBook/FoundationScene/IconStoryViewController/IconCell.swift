//
//  IconCell.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

class IconCell: UITableViewCell {
  private let iconView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.headLine4)
    label.textColor = .black01
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    iconView.image = nil
    titleLabel.text = nil
  }
  
  func configure(with item: IconModel) {
    iconView.image = item.image
    titleLabel.text = item.title
  }
  
  private func configureUI() {
    [iconView, titleLabel].forEach(contentView.addSubview)
    
    iconView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
      $0.width.equalTo(32)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerY.equalTo(iconView)
      $0.leading.equalTo(iconView.snp.trailing).offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
  }
}
