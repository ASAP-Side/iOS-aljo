import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(to: "HomeFeature") {
  [
    .implements(module: .feature(.HomeFeature)) {
      [
        .feature(target: .BaseFeature)
      ]
    },
    .demo(module: .feature(.HomeFeature)) {
      [
        .feature(target: .HomeFeature)
      ]
    }
  ]
}
