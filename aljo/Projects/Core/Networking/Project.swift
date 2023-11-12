import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project
let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.app(to: "Networking") {
  [
    .target("Networking", to: .framework) {
      [
        .project(target: "NetworkingInterface", path: ""),
        .project(target: "FoundationKit", path: "../../Shared/FoundationKit"),
        .external(name: "Alamofire")
      ]
    },
    .target("NetworkingInterface", to: .interface) { [] }
  ]
}
