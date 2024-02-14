import ProjectDescription
import EnvironmentPlugin
import AljoPlugin

/// Interface Method
public extension Target {
  static func interface(
    module: ModulePaths,
    product: Product = .staticLibrary,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .interface, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .interface), product: product)
  }
}

/// Implements Method
public extension Target {
  static func implements(
    module: ModulePaths,
    product: Product = .staticLibrary,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .implementation, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .implementation), product: product)
  }
  
  static func implements(
    module: ModulePaths,
    product: Product = .staticLibrary,
    spec: TargetSpec
  ) -> Target {
    spec.with { spec in
      spec.sources = .implementation
    }
    .toTarget(with: module.targetName(type: .implementation), product: product)
  }
}

/// Demo Method
public extension Target {
  static func demo(
    module: ModulePaths,
    dependencies: [TargetDependency] = []
  ) -> Target {
    let infoFile: InfoPlist = .extendingDefault(
      with: [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
      ]
    )
    
    return TargetSpec(infoPlist: infoFile, sources: .demo, resources: ["Demo/Resources/**"], dependencies: dependencies)
      .toTarget(with: module.targetName(type: .demo), product: .app)
  }
  
  static func demo(
    module: ModulePaths,
    product: Product = .app,
    spec: TargetSpec
  ) -> Target {
    spec.with { spec in
      spec.sources = .demo
      spec.resources = ["Demo/Resources/**"]
      spec.infoPlist = .extendingDefault(
        with: [
          "UIMainStoryboardFile": "",
          "UILaunchStoryboardName": "LaunchScreen"
        ]
      )
    }
    .toTarget(with: module.targetName(type: .demo), product: product)
  }
}

/// Test Method
public extension Target {
  static func tests(
    module: ModulePaths,
    product: Product = .unitTests,
    dependencies: [TargetDependency] = [],
    resources: ResourceFileElements = []
  ) -> Target {
    return TargetSpec(sources: .tests, resources: resources, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .tests), product: product)
  }
  
  static func testing(
    module: ModulePaths,
    product: Product = .unitTests,
    dependencies:  [TargetDependency] = [],
    resources: ResourceFileElements = []
  ) -> Target {
    return TargetSpec(sources: .testing, resources: resources, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .testing), product: product)
  }
}
