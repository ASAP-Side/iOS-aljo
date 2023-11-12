/// Project 생성과 관련된 메서드가 존재합니다.
///

import Foundation
import ProjectDescription

extension TargetScript {
  static let lintScript: String = """
if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

if which swiftlint > /dev/null; then
    swiftlint
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
"""
  
  static let swiftLintTargetScript: TargetScript = .pre(
    script: lintScript,
    name: "Check Lint From SwiftLint",
    basedOnDependencyAnalysis: false
  )
}

public extension Project {
  static func app(to name: String, targets: @escaping () -> [Target]) -> Project {
    return Project(name: name, organizationName: "ASAP", targets: targets())
  }
}

public extension Target {
  enum TargetType: String {
    case app
    case framework
    case staticFramework
    case interface
    case test
    case UITest
    
    var product: Product {
      switch self {
      case .app:
        return .app
      case .framework:
        return .framework
      case .staticFramework, .interface:
        return .staticFramework
      case .test:
        return .unitTests
      case .UITest:
        return .unitTests
      }
    }
    
    func bundleID(to name: String) -> String {
      return "com.asap.\(rawValue).\(name)"
    }
  }
  
  static func target(
    _ name: String,
    to type: TargetType,
    dependencies: @escaping () -> [TargetDependency]
  ) -> Self {
    return Target(
      name: name,
      platform: .iOS,
      product: type.product,
      productName: name,
      bundleId: type.bundleID(to: name),
      deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
      infoPlist: .default,
      sources: .sources,
      resources: nil,
      scripts: [.swiftLintTargetScript],
      dependencies: dependencies(),
      settings: nil,
      coreDataModels: [],
      environment: [:],
      launchArguments: [],
      additionalFiles: []
    )
  }
}

public extension SourceFilesList {
  static let interface: SourceFilesList = "Interface/**"
  static let sources: SourceFilesList = "Sources/**"
}
