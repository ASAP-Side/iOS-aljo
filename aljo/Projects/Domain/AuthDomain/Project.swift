import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  to: "AuthDomain",
  targets: [
    .interface(module: .domain(.AuthDomain)),
    .implements(
      module: .domain(.AuthDomain),
      dependencies: [
        .domain(target: .BaseDomain),
        .domain(target: .AuthDomain, type: .interface)
      ]
    )
  ]
)
