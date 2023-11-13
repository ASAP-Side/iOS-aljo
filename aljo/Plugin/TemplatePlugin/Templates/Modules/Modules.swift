import ProjectDescription

private let layerAttribute = Template.Attribute.required("l")
private let nameAttribute = Template.Attribute.required("n")
private let targetAttribute = Template.Attribute.required("t")

private let template = Template(
    description: "A template for a new module",
    attributes: [
        layerAttribute,
        nameAttribute,
        targetAttribute
    ],
    items: [
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Sources/Source.swift",
            templatePath: "Module.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Project.swift",
            templatePath: "Project.stencil"
        )
    ]
)
