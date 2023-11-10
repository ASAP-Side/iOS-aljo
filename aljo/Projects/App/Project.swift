import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")
let project = Project.app(to: "Application") {
  [
    .target("Application", to: .app) {
      [
        .project(target: "AuthFeature", path: .relativeToRoot("Projects/Features/AuthFeature")),
        .project(target: "HomeFeature", path: .relativeToRoot("Projects/Features/HomeFeature")),
        .project(target: "DashBoardFeature", path: .relativeToRoot("Projects/Features/DashBoardFeature")),
        .project(target: "MyPageFeature", path: .relativeToRoot("Projects/Features/MyPageFeature"))
      ]
    }
  ]
}
