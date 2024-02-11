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
    .implements(
      module: .core(.AJCoreData),
      dependencies: [
        .core(target: .AJCoreData, type: .interface),
        .external(name: "RxSwift")
      ]
    ),
    .testing(
      module: .core(.AJCoreData),
      product: .framework,
      dependencies: [
        .core(target: .AJCoreData, type: .interface)
      ],
      resources: ["Testing/Resources/**"]
    ),
    .tests(
      module: .core(.AJCoreData),
      dependencies: [
        .core(target: .AJCoreData, type: .implementation),
        .core(target: .AJCoreData, type: .testing),
        .external(name: "RxSwift"),
        .external(name: "RxBlocking")
      ]
    )
  ]
)
