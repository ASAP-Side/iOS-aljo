import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin


// MARK: - Project

let targets: [Target] = [
  Target(
    name: "AuthDomain",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.asap.authDomain",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseDomain", path: "../BaseDomain"),
      .project(target: "AuthDomainInterface", path: "")
    ]
  ),
  
  Target(
    name: "AuthDomainInterface",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.authDomainInterface",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Interface/**"]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "AuthDomain", targets: targets)
