import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "AJCoreData",
  targets: [
    .interface(
      module: .core(.AJCoreData),
      dependencies: [
        .external(name: "RxSwift")
      ]
    ),
    .implements(module: .core(.AJCoreData)),
    .testing(module: .core(.AJCoreData), product: .framework),
    .tests(module: .core(.AJCoreData), product: .unitTests)
  ]
)
