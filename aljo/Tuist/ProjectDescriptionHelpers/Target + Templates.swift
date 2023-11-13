import ProjectDescription
import EnvironmentPlugin
import AljoPlugins

public extension Target {
  static func interface(
    module: ModulePaths,
    dependencies: @escaping () -> [TargetDependency] = { [] }
  ) -> Target {
    return TargetSpec(sources: .interface, dependencies: dependencies())
      .toTarget(with: module.targetName(type: .interface), product: .framework)
  }
  
  static func implements(
    module: ModulePaths,
    product: Product = .staticLibrary,
    dependencies: @escaping () -> [TargetDependency] = { [] }
  ) -> Target {
    return TargetSpec(sources: .sources, dependencies: dependencies())
      .toTarget(with: module.targetName(type: .sources), product: product)
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
      deploymentTarget: environmentValues.deployTarget,
      infoPlist: .default,
      sources: .sources,
      resources: .default,
      scripts: [.swiftLintTargetScript],
      dependencies: dependencies(),
      settings: .settings(
        base: environmentValues.baseSetting,
        configurations: [],
        defaultSettings: .recommended
      ),
      coreDataModels: [],
      environment: [:],
      launchArguments: [],
      additionalFiles: []
    )
  }
}
