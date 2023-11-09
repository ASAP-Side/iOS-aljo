import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let targets: [Target] = [
  Target(
    name: "Home",
    platform: .iOS,
    product: .framework,
    productName: "HomeApp",
    bundleId: "com.asap.features.home",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseFeature", path: "../BaseFeature"),
      .project(target: "BaseDomainInterface", path: "../../Domain/BaseDomain")
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
      .project(target: "Home", path: "../Home"),
    ]
  ),
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "Home", targets: targets)
