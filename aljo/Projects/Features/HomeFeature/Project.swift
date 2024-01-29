import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  to: "HomeFeature",
  targets: [
    .implements(
      module: .feature(.HomeFeature),
      dependencies: [
        .feature(target: .BaseFeature)
      ]
    ),
    .demo(
      module: .feature(.HomeFeature),
      dependencies: [
        .feature(target: .HomeFeature)
      ]
    )
  ]
)
