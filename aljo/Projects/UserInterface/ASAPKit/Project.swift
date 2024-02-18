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
        dependencies: [
          .snapKit,
          .rxSwift,
          .rxCocoa
        ]
      )
    ),
    .demo(
      module: .design(.ASAPKit),
      dependencies: [
        .design(target: .ASAPKit, type: .single),
        .snapKit
      ]
    )
  ],
  resourceSynthesizers: .default
)
