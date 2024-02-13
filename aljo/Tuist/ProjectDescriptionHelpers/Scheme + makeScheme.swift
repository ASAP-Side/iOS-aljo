import ProjectDescription

public extension Scheme {  
  static func makeDemoScheme(
    configuration: ConfigurationName,
    name: String
  ) -> Scheme {
      return Scheme(
          name: "\(name)Demo",
          shared: true,
          buildAction: .buildAction(targets: ["\(name)Demo"]),
          runAction: .runAction(configuration: configuration),
          archiveAction: .archiveAction(configuration: configuration),
          profileAction: .profileAction(configuration: configuration),
          analyzeAction: .analyzeAction(configuration: configuration)
      )
  }
}
