import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(to: "Networking") {
  [
    .interface(module: .core(.Networking)),
    .implements(module: .core(.Networking)) {
      [
        .core(target: .Networking, type: .interface),
        .shared(target: .FoundationKit),
        .external(name: "Alamofire")
      ]
    }
  ]
}
