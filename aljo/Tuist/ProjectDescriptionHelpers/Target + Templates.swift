import ProjectDescription

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
