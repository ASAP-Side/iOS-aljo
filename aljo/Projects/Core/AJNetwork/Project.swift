import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "AJNetwork",
  targets: [
    .interface(
      module: .core(.AJNetwork),
      dependencies: [
        .external(name: "Alamofire"),
        .external(name: "RxSwift")
      ]
    ),
    .implements(
      module: .core(.AJNetwork),
      dependencies: [
        .core(target: .AJNetwork, type: .interface),
        .external(name: "Alamofire"),
        .external(name: "RxSwift")
      ]
    ),
    .testing(
      module: .core(.AJNetwork),
      product: .staticLibrary,
      dependencies: [
        .core(target: .AJNetwork, type: .interface),
        .external(name: "Alamofire"),
        .external(name: "RxSwift")
      ]
    ),
    .tests(
      module: .core(.AJNetwork),
      product: .unitTests,
      dependencies: [
        .core(target: .AJNetwork, type: .interface),
        .core(target: .AJNetwork, type: .testing)
      ]
    )
  ]
)
