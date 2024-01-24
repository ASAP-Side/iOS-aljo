import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  to: "UserDomain",
  targets: [
    .interface(module: .domain(.UserDomain)),
    .implements(
      module: .domain(.UserDomain),
      dependencies: [
        .domain(target: .BaseDomain),
        .domain(target: .UserDomain, type: .interface)
      ]
    )
  ]
)
