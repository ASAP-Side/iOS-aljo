import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin
import EnvironmentPlugin

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthDomain") {
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
