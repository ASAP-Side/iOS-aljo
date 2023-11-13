import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthDomain") {
  [
    .interface(module: .domain(.PartyDomain)),
    .implements(module: .domain(.PartyDomain)) {
      [
        .domain(target: .BaseDomain),
        .domain(target: .PartyDomain, type: .interface)
      ]
    }
  ]
}
