//
//  FontCell.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

import SnapKit

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
    label.numberOfLines = 3
    return label
  }()
  
  private let distributionContainerView: UIView = {
    let view = UIView()
    view.layer.backgroundColor = UIColor.gray01.cgColor
    view.layer.cornerRadius = 8
    return view
  }()
  
  private let distributionTitleStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let distributionValueStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.distribution = .fillEqually
    return stackView
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
    
    titleLabel.text = nil
    distributionTitleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    distributionValueStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
  }
  
  func configure(with item: UIFont.PretendardStyle) {
    let paragraph = "세상에게서 도망쳐 run on 나와 저 끝까지 가줘 my lover 나쁜 결말일까 길 잃은 우리 둘 um"
    titleLabel.text = item.rawValue.uppercased()
    paragraphLabel.font = .pretendard(item)
    paragraphLabel.textColor = .title
    paragraphLabel.setTextWithLineHeight(text: paragraph, lineHeight: item.lineHeight)
    setDistributions(to: item)
  }
  
  private func setDistributions(to item: UIFont.PretendardStyle) {
    let sizeTitleLabel = makeDistributionLabel()
    let sizeLabel = makeDistributionLabel()
    
    let weightTitleLabel = makeDistributionLabel()
    let weightLabel = makeDistributionLabel()
    
    let lineHeightTitleLabel = makeDistributionLabel()
    let lineHeightLabel = makeDistributionLabel()
    
    let lineHeight = UIFont.PretendardStyle.headLine4.lineHeight
    sizeTitleLabel.setTextWithLineHeight(text: "Size", lineHeight: lineHeight)
    sizeLabel.setTextWithLineHeight(text: item.size.rawValue.description + " pt", lineHeight: lineHeight)
    
    weightTitleLabel.setTextWithLineHeight(text: "Weight", lineHeight: lineHeight)
    weightLabel.setTextWithLineHeight(text: item.weight.rawValue, lineHeight: lineHeight)
    
    lineHeightTitleLabel.setTextWithLineHeight(text: "LineHeight", lineHeight: lineHeight)
    lineHeightLabel.setTextWithLineHeight(text: item.lineHeight.description, lineHeight: lineHeight)
    
    [sizeTitleLabel, weightTitleLabel, lineHeightTitleLabel].forEach(distributionTitleStackView.addArrangedSubview)
    [sizeLabel, weightLabel, lineHeightLabel].forEach(distributionValueStackView.addArrangedSubview)
  }
  
  private func makeDistributionLabel() -> UILabel {
    let label = UILabel()
    label.font = .pretendard(.headLine4)
    label.textColor = .title
    label.numberOfLines = 1
    return label
  }
}

private extension FontCell {
  func configureUI() {
    configureHierarchy()
    makeConstraints()
  }
  
  func configureHierarchy() {
    [titleLabel, paragraphLabel, distributionContainerView].forEach(contentView.addSubview)
    [
      distributionTitleStackView,
      distributionValueStackView
    ].forEach(distributionContainerView.addSubview)
  }
  
  func makeConstraints() {
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(16)
      $0.leading.equalTo(contentView).offset(16)
      $0.trailing.equalTo(contentView).offset(-16)
      $0.height.equalTo(30)
    }
    
    paragraphLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(16)
      $0.leading.equalTo(contentView.snp.leading).offset(16)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
    }
    
    distributionContainerView.snp.makeConstraints {
      $0.leading.trailing.equalTo(paragraphLabel)
      $0.top.equalTo(paragraphLabel.snp.bottom).offset(16)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-16)
    }
    
    distributionTitleStackView.snp.makeConstraints {
      $0.verticalEdges.leading.equalTo(distributionContainerView).inset(16)
      $0.width.equalTo(100)
    }
    
    distributionValueStackView.snp.makeConstraints {
      $0.verticalEdges.trailing.equalTo(distributionContainerView).inset(16)
      $0.leading.equalTo(distributionTitleStackView.snp.trailing).offset(8)
    }
  }
}
