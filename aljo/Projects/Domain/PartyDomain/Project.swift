import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin


// MARK: - Project

let targets: [Target] = [
  Target(
    name: "PartyDomain",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.asap.partyDomain",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Sources/**"],
    dependencies: [
      .project(target: "BaseDomain", path: "../BaseDomain"),
      .project(target: "PartyDomainInterface", path: "")
    ]
  ),
  
  Target(
    name: "PartyDomainInterface",
    platform: .iOS,
    product: .framework,
    bundleId: "com.asap.partyDomainInterface",
    deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
    sources: ["Interface/**"]
  )
]

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(name: "PartyDomain", targets: targets)
