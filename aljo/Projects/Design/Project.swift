import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
  name: "AJUIKit",
  targets: [
    Target(
      name: "AJUIKit",
      platform: .iOS,
      product: .staticFramework,
      bundleId: "com.design.uikit",
      sources: ["Sources/**"],
      resources: ["Resources/**"]
    )
  ]
)
