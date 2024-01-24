import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "BaseDomain",
  targets: [
    .interface(module: .domain(.BaseDomain)),
    .implements(
      module: .domain(.BaseDomain),
      dependencies: [
        .domain(target: .BaseDomain, type: .interface),
        .core(target: .Networking)
      ]
    )
  ]
)
