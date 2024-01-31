//
//  Provider.swift
//  AJNetworkInterface
//
//  Created by 이태영 on 1/31/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import Foundation

import RxSwift

public protocol Provider {
  static func string(_ router: Router) -> Observable<String>
  static func decodable<T: Decodable>(_ router: Router) -> Observable<T>
  static func data(_ router: Router) -> Observable<Data>
}
