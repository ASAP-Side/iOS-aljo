import XCTest

import RxBlocking

@testable import AJKeychainTesting

// swiftlint:disable all
final class AJKeyChainStorageTest: XCTestCase {
  var sut: MockKeyChainStorage?
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_정상적인_데이터를_저장할때_잘저장되는가() {
    // GIVEN
    let requestData = "Example".data(using: .utf8)!
    let configuration = MockKeyChainConfiguration(isSuccess: true, requestValue: requestData)
    
    sut = MockKeyChainStorage(configuration: configuration)
    
    // WHEN
    let observable = sut?.upsert(item: requestData).toBlocking()
    
    // THEN
    do {
      _ = try observable?.first()
      XCTAssertTrue(true)
    } catch let error {
      XCTAssertThrowsError(error)
    }
  }
  
  func test_비정상적인_데이터를_저장할때_에러가_발생하는가() {
    // GIVEN
    let requestData = Data()
    let configuration = MockKeyChainConfiguration(
      isSuccess: false,
      requestValue: requestData,
      error: .invalidDecode
    )
    
    sut = MockKeyChainStorage(configuration: configuration)
    
    // WHEN
    let observable = sut?.upsert(item: requestData).toBlocking()
    
    // THEN
    do {
      _ = try observable?.first()
      XCTAssertThrowsError("에러가 발생해야 합니다.")
    } catch {
      XCTAssertTrue(true)
    }
  }
  
  func test_데이터가_있는경우_에러발생없이_데이터를_반환하는가() {
    // GIVEN
    let requestData = "AccessToken".data(using: .utf8)!
    let configuration = MockKeyChainConfiguration(isSuccess: true, requestValue: requestData)
    
    sut = MockKeyChainStorage(configuration: configuration)
    
    // WHEN
    let observable = sut?.fetch().toBlocking()
    
    // THEN
    if let result = try! observable?.first() {
      XCTAssertEqual(String(data: result, encoding: .utf8), "AccessToken")
    } else {
      XCTAssertThrowsError("잘못된 데이터를 반환하였습니다.")
    }
  }
  
  func test_데이터가_없는경우_에러가발생하는가() {
    // GIVEN
    let requestData = "AccessToken".data(using: .utf8)!
    let configuration = MockKeyChainConfiguration(
      isSuccess: false,
      requestValue: requestData,
      error: .unknown(999)
    )
    
    sut = MockKeyChainStorage(configuration: configuration)
    
    // WHEN
    let observable = sut?.fetch().toBlocking()
    
    // THEN
    do {
      let result = try observable?.first()
    } catch {
      XCTAssertTrue(true)
    }
  }
}
// swiftlint:disable all
