import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthFeature") {
  [
    .target("AuthFeature", to: .framework) {
      [
        .project(target: "BaseFeature", path: "../BaseFeature"),
        .project(target: "AlarmDomainInterface", path: "../../Domain/AlarmDomain"),
        .project(target: "AuthDomainInterface", path: "../../Domain/AuthDomain")
      ]
    },
    .target("AuthExampleApp", to: .app) {
      [
        .project(target: "AuthFeature", path: "../AuthFeature")
      ]
    }
  ]
}
