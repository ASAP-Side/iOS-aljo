import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
  name: "BaseFeature",
  targets: [
    Target(
      name: "BaseFeature",
      platform: .iOS,
      product: .framework,
      bundleId: "com.features.basefeature",
      sources: ["Sources/**"],
      dependencies: [
        .project(target: "AJUIKit", path: "../../Design")
      ]
    )
  ]
)
