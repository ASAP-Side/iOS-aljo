import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let targets: [Target] = [
  Target(
    name: "BaseDomain",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.asap.baseDomain",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseDomainInterface", path: "")
    ]
  ),
  Target(
    name: "BaseDomainInterface",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.baseDomainInterface",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Interface/**"]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "BaseDomain", targets: targets)
