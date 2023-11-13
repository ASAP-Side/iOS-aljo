import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugin

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthFeature") {
  [
    .implements(module: .feature(.AuthFeature)) {
      [
        .feature(target: .BaseFeature),
        .domain(target: .AlarmDomain, type: .interface),
        .domain(target: .AuthDomain, type: .interface)
      ]
    },
    .demo(module: .feature(.AuthFeature)) {
      [
        .feature(target: .AuthFeature)
      ]
    }
  ]
}
