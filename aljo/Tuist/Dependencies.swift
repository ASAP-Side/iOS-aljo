//
//  Dependencies.swift
//  Config
//
//  Copyright (c) 2023 Minii All rights reserved.

import ProjectDescription

let dependencies = Dependencies(
  carthage: [
    .binary(path: "https://dl.google.com/dl/firebase/ios/carthage/FirebaseMessagingBinary.json", requirement: .exact("10.14.0")),
    .github(path: "SnapKit/SnapKit", requirement: .exact("5.6.0")),
    .github(path: "Alamofire/Alamofire", requirement: .exact("5.6.3")),
    .github(path: "uber/RIBs", requirement: .branch("73a59588319ae23d2a771df0aebc6710bc21bac3")),
    .github(path: "ReactiveX/RxSwift", requirement: .exact("6.6.0")),
  ],
  platforms: [.iOS]
)
