import ProjectDescription

let config = Config(
    plugins: [
      .local(path: .relativeToRoot("Plugins/AljoPlugins")),
      .local(path: .relativeToRoot("Plugins/EnvironmentPlugins"))
    ]
)
