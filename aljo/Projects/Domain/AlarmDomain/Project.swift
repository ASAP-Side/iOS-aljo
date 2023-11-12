import ProjectDescription
import ProjectDescriptionHelpers

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
