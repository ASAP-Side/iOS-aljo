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
extension UITableViewHeaderFooterView: Reusable { }

extension UITableView {
  func dequeueReusable<T: UITableViewCell>(with indexPath: IndexPath) -> T {
    guard let cell: T = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      return T()
    }

    return cell
  }
  
  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    guard let view: T = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
      return T()
    }
    
    return view
  }
}
