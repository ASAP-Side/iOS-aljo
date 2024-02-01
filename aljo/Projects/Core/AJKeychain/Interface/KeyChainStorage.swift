//
//  KeyChain.swift
//  AJKeychainInterface
//
//  Copyright (c) 2024 Minii All rights reserved.

import Foundation
import RxSwift

protocol KeyChainStorage {
  func upsert(item: Data) -> Observable<Void>
  func fetch(to identifier: String) -> Observable<Data>
  func delete(to identifier: String) -> Observable<Void>
}
