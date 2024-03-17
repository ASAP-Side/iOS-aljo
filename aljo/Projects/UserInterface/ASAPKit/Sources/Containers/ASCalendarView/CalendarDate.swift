//
//  CalendarDate.swift
//  ASAPKit
//
//  Copyright (c) 2024 Minii All rights reserved.

import Foundation

struct CalendarDate: Equatable {
  let year: Int
  let month: Int
  let day: Day
  
  var isEmpty: Bool = false
  
  func date(to calendar: Calendar) -> Date? {
    let components = DateComponents(
      calendar: calendar, year: year, month: month, day: day.value
    )
    
    return calendar.date(from: components)
  }
  
  static func generate(year: Int, month: Int, day: Int) -> Self {
    let day = Day(year: year, month: month, day: day)
    return .init(year: year, month: month, day: day)
  }
  
  static func generateEmpty() -> Self {
    let day = Day(year: -1, month: -1, day: -1)
    return .init(year: .zero, month: .zero, day: day, isEmpty: true)
  }
}

struct Day: Equatable {
  let value: Int
  var isPrevious: Bool = false
  
  init(year: Int, month: Int, day: Int) {
    self.value = day
    self.isPrevious = checkIsPrevious(year: year, month: month, day: day)
  }
  
  mutating func checkIsPrevious(year: Int, month: Int, day: Int) -> Bool {
    let currentComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    
    if let currentYear = currentComponents.year, year < currentYear { return true }
    if let currentMonth = currentComponents.month {
      if month < currentMonth { return true }
      
      if month == currentMonth {
        if let currentDay = currentComponents.day, day < currentDay { return true }
      }
    }
    
    return false
  }
}
