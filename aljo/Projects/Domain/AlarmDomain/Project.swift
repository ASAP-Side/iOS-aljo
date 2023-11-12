import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.app(to: "AlarmDomain") {
  [
    .target("AlarmDomain", to: .framework) {
      [
        .project(target: "BaseDomain", path: "../BaseDomain"),
        .project(target: "AlarmDomainInterface", path: "")
      ]
    },
    .target("AlarmDomainInterface", to: .interface) { [] }
  ]
}
