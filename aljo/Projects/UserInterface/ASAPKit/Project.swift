import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "ASAPKit",
  targets: [
    .implements(
      module: .design(.ASAPKit),
      product: .framework,
      spec: TargetSpec(
        resources: .default
      )
    ),
    .demo(
      module: .design(.ASAPKit),
      dependencies: [
        .design(target: .ASAPKit, type: .implementation)
      ]
    )
  ]
)
