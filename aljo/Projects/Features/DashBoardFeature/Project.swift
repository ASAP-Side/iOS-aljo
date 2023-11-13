import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "DashBoardFeature") {
  [
    .implements(module: .feature(.DashBoardFeature)) {
      return [
        .feature(target: .BaseFeature),
        .domain(target: .PartyDomain, type: .interface)
      ]
    },
    .demo(module: .feature(.DashBoardFeature)) {
      return [ .feature(target: .DashBoardFeature) ]
    }
  ]
}
