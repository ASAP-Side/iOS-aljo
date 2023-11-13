import Foundation
import ProjectDescription

public struct ProjectEnvironment {
  let name: String
  let organizationName: String
  let deployTarget: DeploymentTarget
  let platform: Platform
  let baseSetting: SettingsDictionary
}

public let environmentValues = ProjectEnvironment(
  name: "Aljo",
  organizationName: "com.ASAP",
  deployTarget: .iOS(targetVersion: "14.0", devices: .iphone),
  platform: .iOS,
  baseSetting: [:]
)
