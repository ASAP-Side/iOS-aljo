import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "AuthFeature",
  targets: [
    .interface(module: .feature(.AuthFeature))
  ]
)
