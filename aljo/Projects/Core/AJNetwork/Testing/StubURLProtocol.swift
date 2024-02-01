//
//  StubURLProtocol.swift
//  AJNetworkTesting
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import Foundation
import AJNetworkInterface

public final class StubURLProtocol: URLProtocol {
  static var requestHandler: ((URLRequest) -> (HTTPURLResponse, Data))?
  
  public override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  public override func startLoading() {
    guard let handler = StubURLProtocol.requestHandler else {
      return
    }
    
    let (response, data) = handler(request)
    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    client?.urlProtocol(self, didLoad: data)
    client?.urlProtocolDidFinishLoading(self)
  }
}
