import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(to: "MyPageFeature") {
  [
    .implements(module: .feature(.MyPageFeature)) {
      [
        .feature(target: .BaseFeature),
        .domain(target: .UserDomain, type: .interface)
      ]
    }
  ]
}
