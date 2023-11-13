import ProjectDescription

private let layerAttribute = Template.Attribute.required("l")
private let nameAttribute = Template.Attribute.required("n")

private let template = Template(
  description: "A template for a new module's interface target",
  attributes: [
    layerAttribute,
    nameAttribute
  ],
  items: [
    .file(
      path: "Projects/\(layerAttribute)/\(nameAttribute)/Interface/Interface.swift",
      templatePath: "Interface.stencil"
    )
  ]
)
