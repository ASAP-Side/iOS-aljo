import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AJUIKit") {
  [
    .target("AJUIKit", to: .staticFramework) { [] }
  ]
}
