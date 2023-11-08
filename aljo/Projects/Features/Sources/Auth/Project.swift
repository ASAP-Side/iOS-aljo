import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let targets: [Target] = [
  Target(
    name: "Auth",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.feature.auth",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "AJUIKit", path: "../../../Design")
    ]
  ),
  Target(
    name: "AuthApp",
    platform: .iOS,
    product: .app,
    bundleId: "com.asap.feature.authapp",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "Auth", path: "../Auth"),
      .project(target: "AJUIKit", path: "../../../Design")
    ]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "Auth", targets: targets)
