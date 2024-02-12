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
            templatePath: "../Module/Project.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/Sources/SceneDelegate.swift",
            templatePath: "../Demo/SceneDelegate.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/Sources/AppDelegate.swift",
            templatePath: "../Demo/AppDelegate.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/Resources/LaunchScreen.storyboard",
            templatePath: "../Demo/LaunchScreen.stencil"
        ),
        .file(
            path: "Projects/\(layerAttribute)/\(nameAttribute)/Demo/Resources/Info.plist",
            templatePath: "../Demo/AppDelegate.stencil"
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
