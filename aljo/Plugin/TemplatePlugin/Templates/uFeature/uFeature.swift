//
//  uFeature.swift
//  TemplatePlugin
//
//  Created by 이태영 on 1/26/24.
//

import ProjectDescription

private let layerAttribute = Template.Attribute.required("layer")
private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
    description: "A template for new uFeature",
    attributes: [
        layerAttribute,
        nameAttribute,
    ],
    items: [
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Project.swift",
            templatePath: "../Modules/Project.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/SceneDelegate.swift",
            templatePath: "../Demo/SceneDelegate.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/AppDelegate.swift",
            templatePath: "../Demo/AppDelegate.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/LaunchScreen.storyboard",
            templatePath: "../Demo/LaunchScreen.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Interface/Interface.swift",
            templatePath: "../Interface/Interface.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Testing/Testing.swift",
            templatePath: "../Testing/Testing.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
            templatePath: "../Tests/Tests.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Implementation/Implementation.swift",
            templatePath: "../Implementation/Implementation.stencil"
        )
    ]
)
