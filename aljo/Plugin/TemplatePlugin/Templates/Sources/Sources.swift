import ProjectDescription

private let layerAttribute = Template.Attribute.required("l")
private let nameAttribute = Template.Attribute.required("n")

private let template = Template(
    description: "A template for a new module's sources target",
    attributes: [
        layerAttribute,
        nameAttribute
    ],
    items: [
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Sources/Sources.swift",
            templatePath: "Sources.stencil"
        )
    ]
)

