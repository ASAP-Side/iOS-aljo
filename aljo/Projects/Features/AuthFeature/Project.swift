import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin

let project = Project.app(
  to: "AuthFeature",
  targets: [
    .implements(
      module: .feature(.AuthFeature),
      dependencies: [
        .feature(target: .BaseFeature),
        .domain(target: .AlarmDomain, type: .interface),
        .domain(target: .AuthDomain, type: .interface)
      ]
    ),
    .demo(
      module: .feature(.AuthFeature),
      dependencies: [
        .feature(target: .AuthFeature)
      ]
    )
  ]
)
