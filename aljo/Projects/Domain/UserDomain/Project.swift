import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "UserDomain") {
  [
    .interface(module: .domain(.UserDomain)),
    .implements(module: .domain(.UserDomain)) {
      [
        .domain(target: .BaseDomain),
        .domain(target: .UserDomain, type: .interface)
      ]
    }
  ]
}
