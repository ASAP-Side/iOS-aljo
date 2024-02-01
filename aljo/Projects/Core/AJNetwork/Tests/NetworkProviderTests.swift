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
import RxSwift

final class NetworkProviderTests: XCTestCase {
  var sut: NetworkProvider?
  private let disposeBag = DisposeBag()
  
  override func setUpWithError() throws {
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.protocolClasses = [StubURLProtocol.self]
    let session = Session(configuration: sessionConfiguration)
    
    sut = NetworkProvider(session: session)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testGetString() {
    // given
    let data = "Hi".data(using: .utf8)!
    
    StubURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), data)
    }
    // when
    let expectation = XCTestExpectation(description: "NetworkProvider String test")
    var result = ""
    
    sut?.string(DummyRouter.dummyGet)
      .subscribe(onNext: {
        result = $0
        expectation.fulfill()
      }, onError: { error in
        XCTFail(error.localizedDescription)
      })
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 2.0)
    
    XCTAssertEqual("Hi", result)
  }
  
  func testGetData() {
    let data = "Hi".data(using: .utf8)!
    
    StubURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), data)
    }
    // when
    let expectation = XCTestExpectation(description: "NetworkProvider String test")
    var result: Data = Data()
    
    sut?.data(DummyRouter.dummyGet)
      .subscribe(onNext: {
        result = $0
        expectation.fulfill()
      }, onError: { error in
        XCTFail(error.localizedDescription)
      })
      .disposed(by: disposeBag)
    
    // then
    wait(for: [expectation], timeout: 2.0)
    
    XCTAssertEqual(data, result)
  }
  
  func testGetDecodable() {
    let data = dummyJson.data(using: .utf8)!
    
    StubURLProtocol.requestHandler = { _ in
      return (HTTPURLResponse(), data)
    }
    
    let expectation = XCTestExpectation(description: "NetworkProvider String test")
    var result: DummyData = DummyData(title: "")
    
    requestDecodable()?
      .subscribe(onNext: {
        result = $0
        expectation.fulfill()
      }, onError: { error in
        XCTFail(error.localizedDescription)
      })
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 2.0)
    
    XCTAssertEqual("Hi", result.title)
  }
  
  private func requestDecodable() -> Observable<DummyData>? {
    return sut?.decodable(DummyRouter.dummyGet)
  }
}
