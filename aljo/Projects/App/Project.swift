import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin

let project = Project.app(to: "Application") {
  [
    .target("Application", to: .app) {
      return ModulePaths.Feature.allCases.map { TargetDependency.feature(target: $0) }
      + ModulePaths.Domain.allCases.map { TargetDependency.domain(target: $0) }
    }
  ]
}
