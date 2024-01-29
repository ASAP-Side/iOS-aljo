import ProjectDescription

public enum ModulePaths {
  case feature(Feature)
  case domain(Domain)
  case core(Core)
  case shared(Shared)
  case design(Design)
}

public extension ModulePaths {
  enum Feature: String, TargetPathConvertible {
    case base = "Base"
  }
  
  enum Domain: String, TargetPathConvertible { 
    case base = "Base"
  }
  
  enum Core: String, TargetPathConvertible { 
    case base = "Base"
  }
  
  enum Shared: String, TargetPathConvertible { 
    case base = "Base"
  }
  
  enum Design: String, TargetPathConvertible { 
    case base = "Base"
  }
}

public extension ModulePaths {
  func targetName(type: TargetType) -> String {
    switch self {
    case .feature(let feature):
      return feature.targetName(type: type)
    case .domain(let domain):
      return domain.targetName(type: type)
    case .core(let core):
      return core.targetName(type: type)
    case .shared(let shared):
      return shared.targetName(type: type)
    case .design(let design):
      return design.targetName(type: type)
    }
  }
}

public enum TargetType: String {
  case interface = "Interface"
  case implementation = "Implemenetation"
  case tests = "Tests"
  case testing = "Testing"
  case demo = "Demo"
}

public protocol TargetPathConvertible {
  func targetName(type: TargetType) -> String
}

public extension TargetPathConvertible where Self: RawRepresentable {
  func targetName(type: TargetType) -> String {
    return "\(self.rawValue)\(type.rawValue)"
  }
}

extension ModulePaths.Feature: CaseIterable { }
extension ModulePaths.Domain: CaseIterable { }
