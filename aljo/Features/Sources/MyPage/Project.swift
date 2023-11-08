import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let targets: [Target] = [
  Target(
    name: "MyPage",
    platform: .iOS,
    product: .framework,
    bundleId: "com.feature.mypage",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"]
  ),
  Target(
    name: "MyPageApp",
    platform: .iOS,
    product: .app,
    bundleId: "com.feature.mypageApp",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "MyPage", path: "../MyPage")
    ]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "MyPage", targets: targets)
