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
    //    let targets = targets()
    //    let decodeTargets = targets.map {
    //      return target($0) {
    //        [
    //          .project(target: "Auth", path: "../Features/Auth"),
    //          .project(target: "Home", path: "../Features/Home"),
    //          .project(target: "DashBoard", path: "../Features/DashBoard"),
    //          .project(target: "MyPage", path: "../Features/MyPage"),
    //        ]
    //      }
    //    }
    //
    return Project(name: name, organizationName: "ASAP", targets: targets())
  }
  
  //    public static func mainApp() -> Project {
  //        let targets: [Target] = [
  //            Target(
  //                name: "Application",
  //                platform: .iOS,
  //                product: .app,
  //                bundleId: "com.ASAP.app",
  //                deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
  //                sources: ["Sources/**"],
  //                scripts: [
  //                  .pre(
  //                    script: lintScript,
  //                    name: "Check Swift Lint",
  //                    basedOnDependencyAnalysis: false
  //                  )
  //                ],
  //                dependencies: [
  //
  //                ]
  //            )
  //        ]
  //
  //        return Project(
  //            name: "Application",
  //            organizationName: "ASAP",
  //            targets: targets
  //        )
  //    }
}

public extension Target {
  enum TargetType {
    case app
    case framework
    case interface
    case test
    case UITest
    
    var product: Product {
      switch self {
      case .app:
        return .app
      case .framework:
        return .framework
      case .interface:
        return .staticFramework
      case .test:
        return .unitTests
      case .UITest:
        return .unitTests
      }
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
      bundleId: "com.asap.framework.\(name)",
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
