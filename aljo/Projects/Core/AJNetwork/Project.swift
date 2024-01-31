import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "AJNetwork",
  targets: [
    .interface(module: .core(.AJNetwork)),
    .implements(
      module: .core(.AJNetwork),
      dependencies: [
        .core(target: .AJNetwork, type: .interface)
      ]
    ),
    .testing(module: .core(.AJNetwork), product: .staticLibrary)
  ]
)
