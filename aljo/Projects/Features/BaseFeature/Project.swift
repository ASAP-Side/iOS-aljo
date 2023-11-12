import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "BaseFeature") {
  [
    .target("BaseFeature", to: .framework) {
      [
        .project(target: "AJUIKit", path: "../../Design")
      ]
    }
  ]
}
