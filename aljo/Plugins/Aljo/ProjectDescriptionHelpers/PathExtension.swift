import Foundation
import ProjectDescription

public extension ProjectDescription.Path {
  static func relativeToModule(_ path: String) -> Self {
    return .relativeToRoot("Projects/\(path)")
  }
  
  static func relativeToFeature(_ path: String) -> Self {
    return .relativeToRoot("Projects/Features/\(path)")
  }
  
  static func relativeToDomain(_ path: String) -> Self {
    return .relativeToRoot("Projects/Domain/\(path)")
  }
  
  static func relativeToDesign(_ path: String) -> Self {
    return .relativeToRoot("Projects/Design/\(path)")
  }
  
  static func relativeToShare(_ path: String) -> Self {
    return .relativeToRoot("Projects/Shared/\(path)")
  }
  
  static func relativeToCore(_ path: String) -> Self {
    return .relativeToRoot("Projects/Core/\(path)")
  }
}

extension TargetDependency {
  static func module(name: String) -> Self {
    return .project(target: name, path: .relativeToModule(name))
  }
  
  static func domain(_ name: String) -> Self {
    return .project(target: name, path: .relativeToDomain(name))
  }
  
  static func feature(_ name: String) -> Self {
    return .project(target: name, path: .relativeToFeature(name))
  }
}
