/// Project 생성과 관련된 메서드가 존재합니다.
///
import ProjectDescription

extension Project {
    public static func mainApp() -> Project {
        let targets: [Target] = [
            Target(
                name: "Application",
                platform: .iOS,
                product: .app,
                bundleId: "com.ASAP.app",
                deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                sources: ["Sources/**"],
                dependencies: [
                  .project(target: "Features", path: "../Features")
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
