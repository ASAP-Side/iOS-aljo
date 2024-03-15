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
    label.font = .pretendard(.body3)
    return label
  }()
  
  private let previousButton: UIButton = {
    var configuration = UIButton.Configuration.plain()
    configuration.image = .Icon.arrow_left
    return UIButton(configuration: configuration)
  }()
  
  private let nextButton: UIButton = {
    var configuration = UIButton.Configuration.plain()
    configuration.image = .Icon.arrow_right
    return UIButton(configuration: configuration)
  }()
  
  private let weekDayStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private let dateCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(
      CalendarCollectionViewCell.self,
      forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier
    )
    return collectionView
  }()
  
  public init() {
    super.init(frame: .zero)
    
    configureUI()
  }
  
  @available(*, unavailable, message: "스토리보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ASCalendarView: UICollectionViewDataSource {
  public func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int { return 7 }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CalendarCollectionViewCell.identifier,
      for: indexPath
    ) as? CalendarCollectionViewCell else {
      return .init()
    }
    
    return cell
  }
}

extension ASCalendarView: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = self.weekDayStackView.frame.width / 7
    return CGSize(width: width, height: width)
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return .zero
  }
}

private extension ASCalendarView {
  func configureUI() {
    configureHierarchy()
    makeConstraints()
    
    dateCollectionView.dataSource = self
    dateCollectionView.delegate = self
  }
  
  func configureWeekLabels() -> [UILabel] {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ko-KR")
    let dayOfWeek = calendar.shortWeekdaySymbols
    
    return dayOfWeek.map {
      let label = UILabel()
      label.font = .pretendard(.body3)
      label.textColor = .black03
      label.text = $0
      label.textAlignment = .center
      return label
    }
  }
  
  func configureHierarchy() {
    configureWeekLabels().forEach { weekDayStackView.addArrangedSubview($0) }
    [titleLabel, previousButton, nextButton, weekDayStackView, dateCollectionView].forEach(addSubview)
  }
  
  func makeConstraints() {
    previousButton.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(previousButton.snp.bottom)
    }
    
    nextButton.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    
    weekDayStackView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(18)
      $0.horizontalEdges.equalToSuperview()
      $0.centerX.equalToSuperview()
    }
    
    dateCollectionView.snp.makeConstraints {
      $0.top.equalTo(weekDayStackView.snp.bottom).offset(16)
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}
