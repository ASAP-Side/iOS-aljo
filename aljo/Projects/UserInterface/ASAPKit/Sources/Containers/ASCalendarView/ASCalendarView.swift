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
  
  private let calendar: Calendar = {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ko-KR")
    return calendar
  }()
  
  private var calendarDate = Date()
  private var days = [Int]() {
    didSet {
      dateCollectionView.reloadData()
    }
  }
  private var formatter = DateFormatter()
  
  public init() {
    super.init(frame: .zero)
    
    configureCalendar()
    attachActions()
    configureUI()
  }
  
  @available(*, unavailable, message: "스토리보드로 생성할 수 없습니다.")
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Business Logic
private extension ASCalendarView {
  func configureCalendar() {
    let components = calendar.dateComponents([.year, .month], from: Date())
    self.calendarDate = calendar.date(from: components) ?? Date()
    self.formatter.dateFormat = "yyyy년 MM월"
    
    updateCalendar()
  }
  
  private func updateCalendar() {
    updateTitle()
    updateDays()
  }
  
  private func updateTitle() {
    let date = formatter.string(from: calendarDate)
    self.titleLabel.text = date
  }
  
  private func updateDays() {
    days.removeAll()
    
    let startOfTheWeek = startDayOfTheWeekDay()
    let totalDays = startOfTheWeek + endDate()
    
    days = (0..<totalDays).map {
      return $0 < startOfTheWeek ? -1 : ($0 - startOfTheWeek + 1)
    }
  }
  
  private func startDayOfTheWeekDay() -> Int {
    return calendar.component(.weekday, from: calendarDate) - 1
  }
  
  private func endDate() -> Int {
    return calendar.range(of: .day, in: .month, for: calendarDate)?.count ?? Int()
  }
  
  private func updateMonth(add month: Int) {
    guard let updateDate = calendar.date(byAdding: .month, value: month, to: calendarDate) else {
      return
    }
    
    calendarDate = updateDate
    updateCalendar()
  }
}

extension ASCalendarView: UICollectionViewDataSource {
  public func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int { return days.count }
  
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
    let day = days[indexPath.row]
    cell.configureDay(to: day)
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
  
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return .zero
  }
}

private extension ASCalendarView {
  func attachActions() {
    let nextAction = UIAction { [weak self] _ in self?.updateMonth(add: 1) }
    let previousAction = UIAction { [weak self] _ in self?.updateMonth(add: -1) }
    
    nextButton.addAction(nextAction, for: .touchUpInside)
    previousButton.addAction(previousAction, for: .touchUpInside)
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
    [
      titleLabel, previousButton, nextButton,
      weekDayStackView, dateCollectionView
    ].forEach(addSubview)
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
