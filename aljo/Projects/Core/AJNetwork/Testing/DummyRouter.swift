//
//  DummyRouter.swift
//  AJNetworkTesting
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import AJNetworkInterface

import Alamofire

public enum DummyRouter: Router {
  case dummyGet
  case dummyPost
  
  public var baseURL: String {
    return "www.base.com"
  }
  
  public var method: HTTPMethod {
    switch self {
    case .dummyGet:
      return .get
    case .dummyPost:
      return .post
    }
  }
  
  public var path: String {
    switch self {
    case .dummyGet:
      return ""
    case .dummyPost:
      return ""
    }
  }
  
  public var headers: HTTPHeaders {
    switch self {
    case .dummyGet:
      return []
    case .dummyPost:
      return []
    }
  }
  
  public var behavior: RequestBehavior {
    switch self {
    case .dummyGet:
      return .plain
    case .dummyPost:
      return .uploadMultipartFormData(MultipartFormData(), parameters: [:])
    }
  }
}
