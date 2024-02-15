//
//  FontCell.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

final class FontCell: UITableViewCell {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.headLine3)
    label.textColor = .title
    label.textAlignment = .left
    return label
  }()
  
  private let paragraphLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = .zero
    return label
  }()
  
  private let distributionStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 8
    stackView.distribution = .fillEqually
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with item: UIFont.PretendardStyle) {
    let paragraph = "누구든지 병역의무의 이행으로 인하여 불이익한 처우를 받지 아니한다."
    titleLabel.text = item.rawValue.uppercased()
    paragraphLabel.font = .pretendard(item)
    paragraphLabel.textColor = .title
    paragraphLabel.text = paragraph
    print(item)
  }
}

private extension FontCell {
  func configureUI() {
    configureHierarchy()
    makeConstraints()
  }
  
  func configureHierarchy() {
    [titleLabel, paragraphLabel].forEach(contentView.addSubview)
  }
  
  func makeConstraints() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(16)
      $0.horizontalEdges.equalTo(contentView).inset(16)
    }
    
    paragraphLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.leading.equalTo(contentView.snp.leading).offset(24)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-24)
      $0.bottom.equalTo(contentView).offset(-24)
    }
  }
}
