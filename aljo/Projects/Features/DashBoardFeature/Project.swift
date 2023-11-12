import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "DashBoardFeature") {
  [
    .target("DashBoardFeature", to: .framework) {
      [
        .project(target: "BaseFeature", path: "../BaseFeature"),
        .project(target: "PartyDomainInterface", path: "../../Domain/PartyDomain")
      ]
    },
    .target("DashBoardExampleApp", to: .app) {
      [
        .project(target: "DashBoardFeature", path: "../DashBoardFeature"),
      ]
    }
  ]
}
