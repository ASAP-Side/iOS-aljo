import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let targets: [Target] = [
  Target(
    name: "AuthFeature",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.feature.auth",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseFeature", path: "../BaseFeature"),
      .project(target: "AlarmDomainInterface", path: "../../Domain/AlarmDomain"),
      .project(target: "AuthDomainInterface", path: "../../Domain/AuthDomain")
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
      .project(target: "AuthFeature", path: "../AuthFeature")
    ]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "Auth", targets: targets)
