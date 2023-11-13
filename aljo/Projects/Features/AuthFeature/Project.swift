import ProjectDescription
import ProjectDescriptionHelpers
import AljoPlugins

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AuthFeature") {
  [
    .implements(module: .feature(.AuthFeature)) {
      [
        .feature(target: .BaseFeature, type: .interface),
        .domain(target: .AlarmDomain, type: .interface),
        .domain(target: .AuthDomain, type: .interface)
      ]
    }
  ]
}
