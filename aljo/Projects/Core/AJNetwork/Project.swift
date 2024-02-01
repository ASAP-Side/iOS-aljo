import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "AJNetwork",
  settings: .settings(
    base: ["ENABLE_TESTING_SEARCH_PATHS" : "YES"],
    configurations: [.debug(name: .debug), .release(name: .release)]
  ),
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
        .core(target: .AJNetwork, type: .implementation),
        .core(target: .AJNetwork, type: .testing),
        .external(name: "Alamofire"),
        .external(name: "RxSwift")
      ]
    )
  ]
)
