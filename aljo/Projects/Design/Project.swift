import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let targets: [Target] = [

]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
  name: "AJUIKit",
  targets: [
    Target(
      name: "DesignSystem",
      platform: .iOS,
      product: .framework,
      bundleId: "com.design.designSystem",
      sources: ["Sources/DesignSystem"],
      resources: ["Resources/**"]
    )
  ]
)
