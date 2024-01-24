import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin

let project = Project.app(
  to: "BaseFeature",
  targets: [
    .interface(module: .feature(.BaseFeature)),
    .implements(
      module: .feature(.BaseFeature),
      dependencies: [
        .feature(target: .BaseFeature, type: .interface),
        .design(target: .AJUIKit)
      ]
    )
  ]
)
