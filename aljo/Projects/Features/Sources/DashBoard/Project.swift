import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let targets: [Target] = [
  Target(
    name: "DashBoard",
    platform: .iOS,
    product: .framework,
    bundleId: "com.feature.dashboard",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"]
  ),
  Target(
    name: "DashBoardApp",
    platform: .iOS,
    product: .app,
    bundleId: "com.feature.dashboardApp",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "DashBoard", path: "../DashBoard")
    ]
  )
]
// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "DashBoard", targets: targets)
