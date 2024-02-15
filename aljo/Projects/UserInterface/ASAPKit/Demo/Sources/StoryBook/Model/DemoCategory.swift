//
//  DemoCategory.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

enum DemoCategory: Int, CustomStringConvertible, CaseIterable {
  case systemConfiguration
  
  var description: String {
    switch self {
      case .systemConfiguration:
        return "시스템 설정"
    }
  }
  
  static var allCaseDictionary: [Self: [Any]] {
    var dictionary = [Self: [Any]]()
    
    allCases.forEach {
      switch $0 {
        case .systemConfiguration:
          dictionary.updateValue(SystemConfiguration.allCases, forKey: $0)
      }
    }
    return dictionary
  }
}

enum SystemConfiguration: CustomStringConvertible, CaseIterable {
  case font
  case color
  case icon
  
  var description: String {
    switch self {
      case .font:
        return "폰트"
      case .color:
        return "색상"
      case .icon:
        return "아이콘"
    }
  }
  
  var instance: UIViewController {
    switch self {
      case .font:
        return FontStoryViewController()
      default:
        return UIViewController()
    }
  }
}
