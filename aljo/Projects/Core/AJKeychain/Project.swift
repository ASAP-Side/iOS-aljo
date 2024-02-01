import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let targets: [Target] = [
  .interface(module: .core(.AJKeychain), dependencies: [.external(name: "RxSwift")]),
  .implements(
    module: .core(.AJKeychain),
    product: .staticFramework,
    dependencies: [
      .external(name: "RxSwift"),
      .core(target: .AJKeychain, type: .interface)
    ]
  )
]

let project = Project(name: "AJKeychain", targets: targets)
