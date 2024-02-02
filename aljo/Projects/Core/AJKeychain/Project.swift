import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let targets: [Target] = [
  .interface(
    module: .core(.AJKeychain),
    dependencies: [.external(name: "RxSwift")]
  ),
  .implements(
    module: .core(.AJKeychain),
    dependencies: [
      .external(name: "RxSwift"),
      .core(target: .AJKeychain, type: .interface)
    ]
  ),
  .testing(
    module: .core(.AJKeychain),
    product: .staticFramework,
    dependencies: [
      .external(name: "RxSwift"),
      .core(target: .AJKeychain, type: .interface)
    ]
  ),
  .tests(
    module: .core(.AJKeychain),
    product: .unitTests,
    dependencies: [
      .external(name: "RxSwift"),
      .external(name: "RxTest"),
      .external(name: "RxBlocking"),
      .core(target: .AJKeychain, type: .testing)
    ]
  )
]

let project = Project(name: "AJKeychain", targets: targets)
