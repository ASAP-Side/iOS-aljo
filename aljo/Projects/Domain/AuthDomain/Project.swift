import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthDomain") {
  [
    .target("AuthDomain", to: .framework) {
      [
        .project(target: "BaseDomain", path: "../BaseDomain"),
        .project(target: "AuthDomainInterface", path: "")
      ]
    },
    .target("AuthDomainInterface", to: .interface) { [] }
  ]
}
