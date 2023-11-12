import Foundation
import ProjectDescription

public extension Project {
  static let organizationName: String = "ASAP"
  static func app(to name: String, targets: @escaping () -> [Target]) -> Project {
    return Project(
      name: name,
      organizationName: organizationName,
      packages: [],
      settings: nil,
      targets: targets(),
      schemes: [
        Scheme(name: "DEBUG")
      ],
      fileHeaderTemplate: nil,
      additionalFiles: [],
      resourceSynthesizers: []
    )
  }
}

public extension SourceFilesList {
  static let interface: SourceFilesList = "Interface/**"
  static let sources: SourceFilesList = "Sources/**"
}

public extension ResourceFileElements {
  static let `default`: Self = [.folderReference(path: "Resources/**", tags: [])]
}
