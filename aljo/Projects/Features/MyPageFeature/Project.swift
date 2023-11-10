import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let targets: [Target] = [
  Target(
    name: "MyPageFeature",
    platform: .iOS,
    product: .framework,
    bundleId: "com.feature.mypage",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseFeature", path: "../BaseFeature"),
      .project(target: "UserDomainInterface", path: "../../Domain/UserDomain")
    ]
  ),
  Target(
    name: "MyPageApp",
    platform: .iOS,
    product: .app,
    bundleId: "com.feature.mypageApp",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "MyPageFeature", path: "../MyPageFeature"),
    ]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "MyPageFeature", targets: targets)
