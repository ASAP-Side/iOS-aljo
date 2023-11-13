import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(to: "AJUIKit") {
  [
    .implements(
      module: .design(.AJUIKit),
      spec: TargetSpec(
        resources: ["Resources/**"],
        dependencies: [
          .external(name: "SnapKit"),
          .external(name: "RxSwift")
        ]
      )
    )
  ]
}
