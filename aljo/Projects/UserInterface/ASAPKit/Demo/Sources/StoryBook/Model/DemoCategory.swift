//
//  DemoCategory.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

enum DemoCategory: Int, CustomStringConvertible, CaseIterable {
  case systemConfiguration
  case component
  case container
  
  var description: String {
    switch self {
    case .systemConfiguration:
      return "시스템 설정"
    case .component:
      return "COMPONENTS"
    case .container:
      return "CONTAINER"
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
      case .container:
        dictionary.updateValue(ContainerCategory.allCases, forKey: $0)
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
  case rectButton
  case roundButton
  case stepper
  case slider
  
  var description: String {
    switch self {
    case .textView:
      return "ASTextView"
    case .roundButton:
      return "ASRoundButton"
    case .rectButton:
      return "ASRectButton"
    case .slider:
      return "ASSlider"
    case .stepper:
      return "ASStepper"
    }
  }
  
  var instance: UIViewController {
    switch self {
    case .textView:
      return ASTextViewDemoController()
    case .roundButton:
      return ASRoundButtonDemoController()
    case .rectButton:
      return ASRectButtonDemoController()
    case .slider:
      return ASSliderDemoController()
    case .stepper:
      return ASStepperDemoController()
    }
  }
}

enum ContainerCategory: DemoDetail, CustomStringConvertible, CaseIterable {
  case listView
  
  var description: String {
    switch self {
    case .listView:
      return "ASListView"
    }
  }
  
  var instance: UIViewController {
    switch self {
    case .listView:
      return ASListViewDemoController()
    }
  }
}
