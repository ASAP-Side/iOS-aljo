//
//  NetworkProviderTests.swift
//  AJNetworkTests
//
//  Created by 이태영 on 2/1/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import XCTest
import AJNetworkTesting
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
}
