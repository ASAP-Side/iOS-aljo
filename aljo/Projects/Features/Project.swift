import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let targets: [Target] = [
  Target(
    name: "Features",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.asap.feature",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "Home", path: "Sources/Home"),
      .project(target: "Auth", path: "Sources/Auth"),
      .project(target: "DashBoard", path: "Sources/DashBoard"),
      .project(target: "MyPage", path: "Sources/MyPage")
    ]
  )
]
// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "Features", targets: targets)
