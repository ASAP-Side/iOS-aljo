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
    stackView.axis = .horizontal
    stackView.spacing = 8
    stackView.distribution = .fillEqually
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
    stackView.layer.backgroundColor = UIColor.gray01.cgColor
    stackView.layer.cornerRadius = 8
    return stackView
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
    let paragraph = "세상에게서 도망쳐 run on, 나와 저 끝까지 가줘 my lover, 나쁜 결말일까 길 잃은 우리 둘 um, 부서지도록 나를 꼭 안아, 더 사랑히 내게 입맞춰 lover"
    titleLabel.text = item.rawValue.uppercased()
    paragraphLabel.font = .pretendard(item)
    paragraphLabel.textColor = .title
    paragraphLabel.setTextWithLineHeight(text: paragraph, lineHeight: item.lineHeight)
    
    let sizeTitleLabel = makeDistributionLabel()
    let sizeLabel = makeDistributionLabel()
    
    let weightTitleLabel = makeDistributionLabel()
    let weightLabel = makeDistributionLabel()
    
    let lineHeight = UIFont.PretendardStyle.headLine4.lineHeight
    sizeTitleLabel.setTextWithLineHeight(text: "Size", lineHeight: lineHeight)
    sizeLabel.setTextWithLineHeight(text: item.size.rawValue.description + " pt", lineHeight: lineHeight)
    
    weightTitleLabel.setTextWithLineHeight(text: "Weight", lineHeight: lineHeight)
    weightLabel.setTextWithLineHeight(text: item.weight.rawValue, lineHeight: lineHeight)
    
    [sizeTitleLabel, weightTitleLabel].forEach(distributionTitleStackView.addArrangedSubview)
    [sizeLabel, weightLabel].forEach(distributionValueStackView.addArrangedSubview)
  }
  
  private func makeDistributionLabel() -> UILabel {
    let label = UILabel()
    label.font = .pretendard(.headLine4)
    label.textColor = .title
    return label
  }
}

private extension FontCell {
  func configureUI() {
    configureHierarchy()
    makeConstraints()
  }
  
  func configureHierarchy() {
    [titleLabel, paragraphLabel, distributionStackView].forEach(contentView.addSubview)
    [
      distributionTitleStackView,
      distributionValueStackView
    ].forEach(distributionStackView.addArrangedSubview)
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
      $0.height.lessThanOrEqualTo(100)
    }
    
    distributionStackView.snp.makeConstraints {
      $0.leading.trailing.equalTo(paragraphLabel)
      $0.top.equalTo(paragraphLabel.snp.bottom).offset(16)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-16)
    }
  }
}
