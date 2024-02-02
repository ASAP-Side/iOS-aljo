import ProjectDescription
import EnvironmentPlugin
import AljoPlugin

public extension Target {
  static func interface(
    module: ModulePaths,
    product: Product = .staticLibrary,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .interface, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .interface), product: product)
  }
  
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
  
  static func demo(
    module: ModulePaths,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .demo, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .demo), product: .app)
  }
  
  static func tests(
    module: ModulePaths,
    product: Product,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .tests, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .tests), product: product)
  }
  
  static func testing(
    module: ModulePaths,
    product: Product,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .testing, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .testing), product: product)
  }
}
