import ProjectDescription
import EnvironmentPlugin
import AljoPlugin

public extension Target {
  static func interface(
    module: ModulePaths,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .interface, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .interface), product: .framework)
  }
  
  static func implements(
    module: ModulePaths,
    product: Product = .staticLibrary,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .sources, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .sources), product: product)
  }
  
  static func implements(
    module: ModulePaths,
    product: Product = .staticLibrary,
    spec: TargetSpec
  ) -> Target {
    spec.with { spec in
      spec.sources = .sources
    }
    .toTarget(with: module.targetName(type: .sources), product: product)
  }
  
  static func demo(
    module: ModulePaths,
    dependencies: [TargetDependency] = []
  ) -> Target {
    return TargetSpec(sources: .demo, dependencies: dependencies)
      .toTarget(with: module.targetName(type: .demo), product: .app)
  }
}
