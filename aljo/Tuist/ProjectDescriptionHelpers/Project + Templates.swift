import Foundation
import ProjectDescription
import AljoPlugin
import EnvironmentPlugin

public extension Project {
  static func app(
    to name: String,
    options: Options = .options(),
    packages: [Package] = [],
    settings: Settings = .settings(configurations: [.debug(name: .debug), .release(name: .release)]),
    fileHeaderTemplate: FileHeaderTemplate? = nil,
    additionalFiles: [FileElement] = [],
    targets: [Target],
    resourceSynthesizers: [ResourceSynthesizer] = []
  ) -> Project {
    return Project(
      name: name,
      organizationName: environmentValues.organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: [],
      fileHeaderTemplate: fileHeaderTemplate,
      additionalFiles: additionalFiles,
      resourceSynthesizers: resourceSynthesizers
    )
  }
}

public extension SourceFilesList {
  static let interface: SourceFilesList = "Interface/**"
  static let sources: SourceFilesList = "Sources/**"
  static let demo: SourceFilesList = "Demo/Sources/**"
  static let implementation: SourceFilesList = "Implementation/**"
  static let testing: SourceFilesList = "Testing/**"
  static let tests: SourceFilesList = "Tests/**"
}

public extension ResourceFileElements {
  static let `default`: Self = [.folderReference(path: "Resources/", tags: [])]
}
