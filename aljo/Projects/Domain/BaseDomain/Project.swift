import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthDomain") {
  [
    .target("BaseDomain", to: .framework) {
      [
        .project(target: "BaseDomainInterface", path: ""),
        .project(target: "NetworkingInterface", path: "../../Core/Networking")
      ]
    },
    .target("BaseDomainInterface", to: .interface) { [] }
  ]
}
