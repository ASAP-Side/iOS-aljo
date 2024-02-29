//
//  ColorCell.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

class ColorCell: UITableViewCell {
  private let colorView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 25
    return imageView
  }()
  
  private let distributionContainer: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.headLine3)
    label.textColor = .black01
    label.textAlignment = .left
    return label
  }()
  
  private let distributionLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.body4)
    label.textColor = .black04
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with model: ASAPColorModel) {
    colorView.image = UIImage(color: model.color, size: CGSize(width: 50, height: 50))
    colorView.layer.cornerRadius = 25
    colorView.clipsToBounds = true
    titleLabel.text = model.title
    distributionLabel.text = model.color.toHexStr()
  }
  
  private func configureUI() {
    [colorView, distributionContainer].forEach(contentView.addSubview)
    [titleLabel, distributionLabel].forEach(distributionContainer.addArrangedSubview)
    
    colorView.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview().inset(16)
      $0.width.equalTo(colorView.snp.height)
    }
    
    distributionContainer.snp.makeConstraints {
      $0.verticalEdges.equalTo(colorView)
      $0.leading.equalTo(colorView.snp.trailing).offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
  }
}
