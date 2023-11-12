import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthDomain") {
  [
    .target("PartyDomain", to: .framework) {
      [
        .project(target: "BaseDomain", path: "../BaseDomain"),
        .project(target: "PartyDomainInterface", path: "")
      ]
    },
    .target("PartyDomainInterface", to: .interface) { [] }
  ]
}
