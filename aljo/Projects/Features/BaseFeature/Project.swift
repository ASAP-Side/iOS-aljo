import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugins

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "BaseFeature") {
  [
    .interface(module: .feature(.BaseFeature)),
    .implements(module: .feature(.BaseFeature)) {
      [
        .design(target: .AJUIKit)
      ]
    }
  ]
}
