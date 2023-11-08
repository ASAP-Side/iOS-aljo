import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin


let targets: [Target] = [
  Target(
    name: "DesignSystem",
    platform: .iOS,
    product: .framework,
    bundleId: "com.design.designSystem",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "DesignSystem", targets: targets)
