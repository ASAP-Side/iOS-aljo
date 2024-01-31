//
//  NetworkProvider.swift
//  AJNetworkImplemenetation
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import AJNetworkInterface
import Foundation

import RxSwift
import Alamofire

struct NetworkProvider: Provider {
  static func string(_ router: Router) -> Observable<String> {
    return request(to: router).compactMap { String(data: $0, encoding: .utf8) }
  }
  
  static func decodable<T: Decodable>(_ router: Router) -> Observable<T> {
    return request(to: router).decode(type: T.self, decoder: JSONDecoder())
  }
  
  static func data(_ router: Router) -> Observable<Data> {
    return request(to: router)
  }
}

// MARK: - Private
extension NetworkProvider {
  static func request(to router: Router) -> Observable<Data> {
    if case let .uploadMultipartFormData(multipartFormData, _) = router.behavior {
      return upload(to: router, with: multipartFormData)
    }
    
    return Observable.create { emitter in
      let request = AF.request(router)
        .validate()
        .responseData { response in
          switch response.result {
          case .success(let data):
            emitter.onNext(data)
          case .failure(let error):
            emitter.onError(error)
          }
        }
      
      return Disposables.create {
        request.cancel()
      }
    }
  }
  
  static func upload(to router: Router, with multipartFormData: MultipartFormData) -> Observable<Data> {
    return Observable.create { emitter in
      let request = AF.upload(multipartFormData: multipartFormData, with: router)
        .validate()
        .responseData { response in
          switch response.result {
          case .success(let data):
            emitter.onNext(data)
          case .failure(let error):
            emitter.onError(error)
          }
        }
      
      return Disposables.create {
        request.cancel()
      }
    }
  }
}
