import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let targets: [Target] = [
  Target(
    name: "Networking",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.asap.coreNetworking",
    deploymentTarget: .iOS(targetVersion: "14.9", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "NetworkingInterface", path: "")
    ]
  ),
  Target(
    name: "NetworkingInterface",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.coreNetworkingInterface",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Interface/**"]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "Networking", targets: targets)
