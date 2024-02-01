import ProjectDescription

public extension TargetScript {
  static let swiftLintTargetScript: TargetScript = .pre(
    path: Path.relativeToRoot("Scripts/SwiftLintRunScript.sh"),
    name: "Check Lint From SwiftLint",
    basedOnDependencyAnalysis: false
  )
}
