import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthDomain") {
  [
    .interface(module: .domain(.AuthDomain)),
    .implements(module: .domain(.AuthDomain)) {
      [
        .domain(target: .BaseDomain),
        .domain(target: .AuthDomain, type: .interface)
      ]
    }
  ]
}
