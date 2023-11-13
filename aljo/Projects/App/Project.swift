import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugins
import EnvironmentPlugin

let targets: [Target] = [
  Target(
    name: environmentValues.name,
    platform: environmentValues.platform,
    product: .app,
    bundleId: environmentValues.organizationName + "." + environmentValues.name,
    deploymentTarget: environmentValues.deployTarget,
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    scripts: [.swiftLintTargetScript],
    dependencies: ModulePaths.Feature.allCases.map { TargetDependency.feature(target: $0) }
      + ModulePaths.Domain.allCases.map { TargetDependency.domain(target: $0) },
    settings: .settings(base: environmentValues.baseSetting)
  )
]

let project = Project(
  name: environmentValues.name,
  organizationName: environmentValues.organizationName,
  targets: targets
)
