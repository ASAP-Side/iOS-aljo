import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let targets: [Target] = [
  Target(
    name: "HomeFeature",
    platform: .iOS,
    product: .framework,
    productName: "HomeFeature",
    bundleId: "com.asap.features.homeFeature",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseFeature", path: "../BaseFeature")
    ]
  ),
  Target(
    name: "HomeApp",
    platform: .iOS,
    product: .app,
    bundleId: "com.asap.homeApp",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "HomeFeature", path: "../HomeFeature"),
    ]
  ),
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "HomeFeature", targets: targets)
