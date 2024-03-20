import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "FlowKit",
  targets: [
    .interface(module: .shared(.FlowKit))
  ]
)
