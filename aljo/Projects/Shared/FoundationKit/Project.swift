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

let project = Project(name: "FoundationKit", targets: targets)
