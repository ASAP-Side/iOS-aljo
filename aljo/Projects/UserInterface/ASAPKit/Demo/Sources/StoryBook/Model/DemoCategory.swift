//
//  DemoCategory.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

enum DemoCategory: Int, CustomStringConvertible, CaseIterable {
  case systemConfiguration
  case component
  
  var description: String {
    switch self {
    case .systemConfiguration:
      return "시스템 설정"
    case .component:
      return "COMPONENTS"
    }
  }
  
  static var allCaseDictionary: [Self: [DemoDetail]] {
    var dictionary = [Self: [DemoDetail]]()
    
    allCases.forEach {
      switch $0 {
      case .systemConfiguration:
        dictionary.updateValue(SystemConfiguration.allCases, forKey: $0)
      case .component:
        dictionary.updateValue(ComponentsCategory.allCases, forKey: $0)
      }
    }
    return dictionary
  }
}

protocol DemoDetail {
  var instance: UIViewController { get }
}

enum SystemConfiguration: DemoDetail, CustomStringConvertible, CaseIterable {
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
    case .color:
      return ColorStoryViewController()
    case .icon:
      return IconStoryViewController()
    }
  }
}

enum ComponentsCategory: DemoDetail, CustomStringConvertible, CaseIterable {
  case textView
  case roundButton
  case rectButton
<<<<<<< HEAD
  case slider
=======
  case roundButton
>>>>>>> develop
  
  var description: String {
    switch self {
      case .textView:
        return "ASTextView"
<<<<<<< HEAD
      case .roundButton:
        return "ASRoundButton"
      case .rectButton:
        return "ASRectButton"
      case .slider:
        return "ASSlider"
=======
      case .rectButton:
        return "ASRectButton"
      case .roundButton:
        return "ASRoundButton"
>>>>>>> develop
    }
  }
  
  var instance: UIViewController {
    switch self {
      case .textView:
        return ASTextViewDemoController()
<<<<<<< HEAD
      case .roundButton:
        return ASRoundButtonDemoController()
      case .rectButton:
        return ASRectButtonDemoController()
      case .slider:
        return ASSliderDemoController()
=======
      case .rectButton:
        return ASRectButtonDemoController()
      case .roundButton:
        return ASRoundButtonDemoController()
>>>>>>> develop
    }
  }
}
