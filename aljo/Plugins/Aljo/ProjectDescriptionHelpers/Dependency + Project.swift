import ProjectDescription

extension TargetDependency {
  public struct Project {
    public struct Module { }
    public struct Network { }
    public struct UserInterface { }
  }
}

public extension TargetDependency.Project {
  static let Domain = TargetDependency.module(name: "Domain")
}
