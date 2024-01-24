import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  to: "MyPageFeature",
  targets: [
    .implements(
      module: .feature(.MyPageFeature),
      dependencies: [
        .feature(target: .BaseFeature),
        .domain(target: .UserDomain, type: .interface)
      ]
    )
  ]
)
