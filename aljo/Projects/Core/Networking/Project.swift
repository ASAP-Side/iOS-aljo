import ProjectDescription
import ProjectDescriptionHelpers

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
