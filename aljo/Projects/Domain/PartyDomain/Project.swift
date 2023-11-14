import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(to: "PartyDomain") {
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
