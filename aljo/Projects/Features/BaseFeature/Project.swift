import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "BaseFeature") {
  [
    .target("BaseFeature", to: .framework) {
      [
        .project(target: "AJUIKit", path: "../../Design"),
        .external(name: "RIBs")
      ]
    }
  ]
}
