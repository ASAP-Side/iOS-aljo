import ProjectDescription
import ProjectDescriptionHelpers

// Plugins
import AljoPlugin
import EnvironmentPlugin

let project = Project.app(
  to: "ASAPKit",
  targets: [
    .single(
      module: .design(.ASAPKit),
      spec: TargetSpec(
        resources: ["Resources/**"],
        dependencies: [.rxSwift, .rxCocoa, .snapKit]
      )
    ),
    .demo(
      module: .design(.ASAPKit),
      dependencies: [
        .design(target: .ASAPKit, type: .single),
        .rxSwift,
        .rxCocoa,
        .snapKit
      ]
    )
  ],
  resourceSynthesizers: .default
)
