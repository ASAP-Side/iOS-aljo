//
//  AppDelegate.swift
//  Application
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.nativeBounds)
    let controller = UIViewController()
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    return true
  }
}
