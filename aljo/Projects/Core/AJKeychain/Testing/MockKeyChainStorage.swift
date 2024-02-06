//
//  MockKeyChainStorage.swift
//  AJKeychainInterface
//
//  Copyright (c) 2024 Minii All rights reserved.

import Foundation
import RxSwift
import AJKeychainInterface

final class MockKeyChainStorage: KeyChainStorage {
  private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
  private let configuration: MockKeyChainConfiguration
  
  init(configuration: MockKeyChainConfiguration) {
    self.configuration = configuration
  }
  
  func upsert(item: Data) -> Observable<Void> {
    return Observable.create { observer in
      if self.configuration.isSuccess == true {
        observer.onNext(())
      } else {
        observer.onError(self.configuration.error)
      }
      
      return Disposables.create()
    }
    .subscribe(on: scheduler)
  }
  
  func fetch() -> Observable<Data> {
    return Observable.create { observer in
      if self.configuration.isSuccess == true {
        observer.onNext(self.configuration.requestValue)
      } else {
        observer.onError(self.configuration.error)
      }
      
      return Disposables.create()
    }
    .subscribe(on: scheduler)
  }
  
  func delete() -> Observable<Void> {
    return Observable.create { observer in
      if self.configuration.isSuccess == true {
        observer.onNext(())
      } else {
        observer.onError(self.configuration.error)
      }
      
      return Disposables.create()
    }
    .subscribe(on: scheduler)
  }
}
