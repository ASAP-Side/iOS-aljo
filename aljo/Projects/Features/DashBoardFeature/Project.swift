import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  to: "DashBoardFeature",
  targets: [
    .implements(
      module: .feature(.DashBoardFeature),
      dependencies: [
        .feature(target: .BaseFeature),
        .domain(target: .PartyDomain, type: .interface)
      ]
    ),
    .demo(
      module: .feature(.DashBoardFeature),
      dependencies: [ 
        .feature(target: .DashBoardFeature)
      ]
    )
  ]
)
