import XCTest
@testable import AJCoreDataImplemenetation
@testable import AJCoreDataTesting

final class AJCoreDataTests: XCTestCase {
  var sut: DefaultCoreDataStorage?
  
  override func setUpWithError() throws {
    let worker = StubCoreDataWorker.default
    sut = DefaultCoreDataStorage(worker: worker)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
}
