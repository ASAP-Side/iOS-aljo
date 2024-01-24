import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
  to: "AJUIKit",
  targets: [
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
)
