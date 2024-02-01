//
//  RouterTests.swift
//  AJNetworkTests
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import XCTest
@testable import AJNetworkTesting

final class RouterTests: XCTestCase {
  var sut: DummyRouter?
  
  override func setUpWithError() throws {
    sut = .dummy
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testAsURLRequest() throws {
    // given
    var request = try URLRequest(url: "www.base.com/path", method: .get)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    // when
    let result = try sut?.asURLRequest()
    
    // then
    XCTAssertEqual(request, result)
  }
}
