//
//  NetworkProviderTests.swift
//  AJNetworkTests
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import XCTest
@testable import AJNetworkTesting
@testable import AJNetworkImplemenetation

import Alamofire
import RxBlocking
import RxSwift

final class NetworkProviderTests: XCTestCase {
  var sut: NetworkProvider?
  
  override func setUpWithError() throws {
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.protocolClasses = [StubURLProtocol.self]
    let session = Session(configuration: sessionConfiguration)
    
    sut = NetworkProvider(session: session)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_string메서드를통해네트워크요청을보낸후응답으로String타입의값을방출해야한다() throws {
    // given
    let data = "Hi".data(using: .utf8)!
    
    StubURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), data)
    }
    // when
    let observable = sut?.string(DummyRouter.dummyGet)
    
    // then
    guard let result = try observable?.toBlocking().first() else {
      XCTFail("Fail")
      return
    }
    
    XCTAssertEqual("Hi", result)
  }
  
  func test_data메서드를통해네트워크요청을보낸후응답으로Data타입의값을방출해야한다() throws {
    let data = "Hi".data(using: .utf8)!
    
    StubURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), data)
    }
    // when
    let observable = sut?.data(DummyRouter.dummyGet)
    
    // then
    guard let result = try observable?.toBlocking().first() else {
      XCTFail("Fail")
      return
    }
    
    XCTAssertEqual(data, result)
  }
  
  func test_decodable메서드를통해네트워크요청을보낸후응답으로Decodable타입의값을방출해야한다() throws {
    // given
    let data = dummyJson.data(using: .utf8)!
    
    StubURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), data)
    }
    
    // when
    let observable = requestDecodable()
    
    // then
    guard let result = try observable?.toBlocking().first() else {
      XCTFail("Fail")
      return
    }
    
    XCTAssertEqual("Hi", result.title)
  }
  
  private func requestDecodable() -> Observable<DummyData>? {
    return sut?.decodable(DummyRouter.dummyGet)
  }
}
