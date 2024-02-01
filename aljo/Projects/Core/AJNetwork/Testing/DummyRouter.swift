//
//  DummyRouter.swift
//  AJNetworkTesting
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import AJNetworkInterface

import Alamofire

enum DummyRouter: Router {
  case dummyGet
  case dummyPost
  
  var baseURL: String {
    return "www.base.com"
  }
  
  var method: HTTPMethod {
    switch self {
    case .dummyGet:
      return .get
    case .dummyPost:
      return .post
    }
  }
  
  var path: String {
    switch self {
    case .dummyGet:
      return ""
    case .dummyPost:
      return ""
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .dummyGet:
      return []
    case .dummyPost:
      return []
    }
  }
  
  var behavior: RequestBehavior {
    switch self {
    case .dummyGet:
      return .plain
    case .dummyPost:
      return .uploadMultipartFormData(MultipartFormData(), parameters: [:])
    }
  }
}
