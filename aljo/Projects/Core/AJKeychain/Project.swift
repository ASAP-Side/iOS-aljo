import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let targets: [Target] = [
  .interface(module: .core(.AJKeychain), dependencies: [.external(name: "RxSwift")])
]

let project = Project(name: "AJKeychain", targets: targets)
