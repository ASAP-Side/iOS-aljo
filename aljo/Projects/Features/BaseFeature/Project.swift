import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin

let project = Project.app(to: "BaseFeature") {
  [
    .interface(module: .feature(.BaseFeature)),
    .implements(module: .feature(.BaseFeature)) {
      [
        .feature(target: .BaseFeature, type: .interface),
        .design(target: .AJUIKit)
      ]
    }
  ]
}
