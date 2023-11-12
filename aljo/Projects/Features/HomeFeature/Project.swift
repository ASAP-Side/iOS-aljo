import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "HomeFeature") {
  [
    .target("HomeFeature", to: .framework) {
      [
        .project(target: "BaseFeature", path: "../BaseFeature")
      ]
    },
    .target("HomeExampleApp", to: .app) {
      [
        .project(target: "HomeFeature", path: "../HomeFeature")
      ]
    }
  ]
}
