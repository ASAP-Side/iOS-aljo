import ProjectDescription

let config = Config(
    plugins: [
      .local(path: .relativeToRoot("Plugin/AljoPlugin")),
      .local(path: .relativeToRoot("Plugin/EnvironmentPlugin")),
      .local(path: .relativeToRoot("Plugin/TemplatePlugin"))
    ]
)
