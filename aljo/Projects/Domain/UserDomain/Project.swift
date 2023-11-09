import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin


// MARK: - Project

let targets: [Target] = [
  Target(
    name: "UserDomain",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.asap.userDomain",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseDomain", path: "../BaseDomain"),
      .project(target: "UserDomainInterface", path: "")
    ]
  ),
  
  Target(
    name: "UserDomainInterface",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.userDomainInterface",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Interface/**"]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "UserDomain", targets: targets)
