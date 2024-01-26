//
//  Testing.swift
//  TemplatePlugin
//
//  Created by 이태영 on 1/26/24.
//

import ProjectDescription

private let layerAttribute = Template.Attribute.required("layer")
private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "Template for testing target",
    attributes: [
        layerAttribute,
        nameAttribute
    ],
    items: [
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Testing/Testing.swift",
            templatePath: "Testing.stencil"
        )
    ]
)
