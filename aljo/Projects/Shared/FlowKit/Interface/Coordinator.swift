//
//  Coordinator.swift
//  FlowKitInterface
//
//  Created by 이태영 on 3/20/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//
import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Self] { get set }

  func start()
  func close(to controller: UIViewController)
}
