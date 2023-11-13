import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
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
