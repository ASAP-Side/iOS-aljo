import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(to: "BaseDomain") {
  [
    .interface(module: .domain(.BaseDomain)),
    .implements(module: .domain(.BaseDomain)) {
      [
        .domain(target: .BaseDomain, type: .interface),
        .core(target: .Networking)
      ]
    }
  ]
}
