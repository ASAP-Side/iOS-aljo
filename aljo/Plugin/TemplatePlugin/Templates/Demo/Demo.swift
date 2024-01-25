//
//  Demo.swift
//  TemplatePlugin
//
//  Created by 이태영 on 1/25/24.
//

import ProjectDescription

private let layerAttribute = Template.Attribute.required("layer")
private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for a new module's demo target",
    attributes: [
        layerAttribute,
        nameAttribute
    ],
    items: [
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/Sources/AppDelegate.swift",
            templatePath: "AppDelegate.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/Sources/SceneDelegate.swift",
            templatePath: "SceneDelegate.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/Resources/LaunchScreen.storyboard",
            templatePath: "LaunchScreen.stencil"
        )
    ]
)
