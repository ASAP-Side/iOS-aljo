import Foundation
import ProjectDescription

public struct ProjectEnvironment {
  public let name: String
  public let organizationName: String
  public let deployTarget: DeploymentTarget
  public let platform: Platform
  public let baseSetting: SettingsDictionary
}

public let environmentValues = ProjectEnvironment(
  name: "Aljo",
  organizationName: "com.ASAP",
  deployTarget: .iOS(targetVersion: "14.0", devices: .iphone),
  platform: .iOS,
  baseSetting: [:]
)
