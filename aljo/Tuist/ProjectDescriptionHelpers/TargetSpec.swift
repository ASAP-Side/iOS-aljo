import Foundation
import ProjectDescription
import EnvironmentPlugin
import AljoPlugin

public struct TargetSpec {
  public var name: String
  public var platform: Platform
  public var product: Product
  public var productName: String?
  public var bundleId: String?
  public var deploymentTarget: DeploymentTarget?
  public var infoPlist: InfoPlist
  public var sources: SourceFilesList?
  public var resources: ResourceFileElements?
  public var copyFiles: [CopyFilesAction]?
  public var headers: Headers?
  public var entitlements: Path?
  public var scripts: [TargetScript]
  public var dependencies: [TargetDependency]
  public var settings: Settings?
  public var coreDataModels: [CoreDataModel]
  public var environment: [String : String]
  public var launchArguments: [LaunchArgument]
  public var additionalFiles: [FileElement]
  
  public init(
    name: String = "",
    platform: Platform = environmentValues.platform,
    product: Product = .staticLibrary,
    productName: String? = nil,
    bundleId: String? = nil,
    deploymentTarget: DeploymentTarget? = environmentValues.deployTarget,
    infoPlist: InfoPlist = .default,
    sources: SourceFilesList? = .sources,
    resources: ResourceFileElements? = nil,
    copyFiles: [CopyFilesAction]? = nil,
    headers: Headers? = nil,
    entitlements: Path? = nil,
    scripts: [TargetScript] = [.swiftLintTargetScript],
    dependencies: [TargetDependency] = [],
    settings: Settings? = nil,
    coreDataModels: [CoreDataModel] = [],
    environment: [String: String] = [:],
    launchArguments: [LaunchArgument] = [],
    additionalFiles: [FileElement] = []
  ) {
    self.name = name
    self.platform = platform
    self.product = product
    self.productName = productName
    self.bundleId = bundleId
    self.deploymentTarget = deploymentTarget
    self.infoPlist = infoPlist
    self.sources = sources
    self.resources = resources
    self.copyFiles = copyFiles
    self.headers = headers
    self.entitlements = entitlements
    self.scripts = scripts
    self.dependencies = dependencies
    self.settings = settings
    self.coreDataModels = coreDataModels
    self.environment = environment
    self.launchArguments = launchArguments
    self.additionalFiles = additionalFiles
  }
  
  func toTarget(with name: String, product: Product? = nil) -> Target {
    return Target(
      name: name,
      platform: platform,
      product: product ?? self.product,
      productName: productName,
      bundleId: bundleId ?? "\(environmentValues.organizationName).\(name)",
      deploymentTarget: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      copyFiles: copyFiles,
      headers: headers,
      entitlements: entitlements,
      scripts: scripts,
      dependencies: dependencies,
      settings: settings,
      coreDataModels: coreDataModels,
      environment: environment,
      launchArguments: launchArguments,
      additionalFiles: additionalFiles
    )
  }
  
  func with(_ block: (inout Self) throws -> Void) rethrows -> Self {
    var copy = self
    try block(&copy)
    return copy
  }
}
