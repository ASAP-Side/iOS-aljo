//
//  CalendarCollectionViewCell.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

final class CalendarCollectionViewCell: UICollectionViewCell {
  // TODO: - REUSABLE 프로토콜 만들어서 채택하기
  static let identifier: String = "CalendarCollectionViewCell"
  
  private let dayLabel: UILabel = {
    let label = UILabel()
    label.font = .pretendard(.body3)
    label.textColor = .label
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
  }
  
  @available(*, unavailable, message: "스토리보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    dayLabel.text = nil
  }
  
  private func configure() {
    contentView.addSubview(dayLabel)
    
    dayLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    contentView.layer.backgroundColor = UIColor.red02.cgColor
  }
  
  func configureDay(to day: Int) {
    if day < 0 { return }
    
    dayLabel.text = "\(day)"
  }
}
