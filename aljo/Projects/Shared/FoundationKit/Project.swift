import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
  Target(
    name: "FoundationKit",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.share.foundation",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"]
  )
]

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "FoundationKit", targets: targets)
