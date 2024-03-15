//
//  ASCalendarView.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

public final class ASCalendarView: UIView {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "2023년 12월"
    return label
  }()
  
  public init() {
    super.init(frame: .zero)
  }
  
  @available(*, unavailable, message: "스토리보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension ASCalendarView {
  func configureUI() {
    configureHierarchy()
    makeConstraints()
  }
  
  func configureHierarchy() {
    [titleLabel].forEach(addSubview)
  }
  
  func makeConstraints() {
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.centerX.equalToSuperview()
    }
  }
}
