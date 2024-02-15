//
//  Reusable + Extension.swift
//  ASAPKitDemo
//
//  Copyright (c) 2024 Minii All rights reserved.

import UIKit

protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(reflecting: Self.self)
  }
}

extension UITableViewCell: Reusable { }

extension UITableView {
  func dequeueReusable<T: UITableViewCell>(with indexPath: IndexPath) -> T {
    guard let cell: T = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      return T()
    }
    
    return cell
  }
}
