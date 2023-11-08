import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains Home App target and Home unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

let targets: [Target] = [
  Target(
    name: "Home",
    platform: .iOS,
    product: .framework,
    productName: "HomeApp",
    bundleId: "com.asap.features.home",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"]
  ),
  Target(
    name: "HomeApp",
    platform: .iOS,
    product: .app,
    bundleId: "com.asap.homeApp",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "Home", path: "../Home")
    ]
  ),
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "Home", targets: targets)
