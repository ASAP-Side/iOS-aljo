/// Project 생성과 관련된 메서드가 존재합니다.
///

import Foundation
import ProjectDescription

extension Project {
  static let lintScript: String = """
    ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")

    ${ROOT_DIR}/swiftlint --config ${ROOT_DIR}/.swiftlint.yml

    """
  
    public static func mainApp() -> Project {
        let targets: [Target] = [
            Target(
                name: "Application",
                platform: .iOS,
                product: .app,
                bundleId: "com.ASAP.app",
                deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                sources: ["Sources/**"],
                scripts: [
                  .pre(script: lintScript, name: "Check Swift Lint", basedOnDependencyAnalysis: false)
                ],
                dependencies: [
                  .project(target: "Auth", path: "../Features/Auth"),
                  .project(target: "Home", path: "../Features/Home"),
                  .project(target: "DashBoard", path: "../Features/DashBoard"),
                  .project(target: "MyPage", path: "../Features/MyPage"),
                ]
            )
        ]
        
        return Project(
            name: "Application",
            organizationName: "ASAP",
            targets: targets
        )
    }
}
