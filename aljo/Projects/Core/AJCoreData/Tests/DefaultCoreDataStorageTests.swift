import XCTest
@testable import AJCoreDataImplemenetation
@testable import AJCoreDataTesting

import RxBlocking
import RxSwift


final class DefaultCoreDataStorageTests: XCTestCase {
  private let sut = DefaultCoreDataStorage(worker: StubCoreDataWorker.default)
  private let disposeBag = DisposeBag()
  
  override func tearDownWithError() throws {
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    deleteAll(dispatchGroup: dispatchGroup)
    dispatchGroup.wait()
  }
  
  // MARK: Test Method
  func test_새로운데이터를넣고다시가져왔을때동일한id의데이터가나와야한다() throws {
    // given
    let dummy = DummyTestEntity(id: "1", title: "hi")
    
    // when
    var result: DummyTestEntity?
    let observable = sut.upsert(entities: [dummy])
      .flatMap { _ -> Observable<[DummyTestEntity]> in
        return self.sut.fetch(with: nil, sortDescriptors: nil, limit: 1)
      }
      .compactMap {
        $0.first
      }
    
    // then
    guard let result = try observable.toBlocking().first() else {
      XCTFail("Fail")
      return
    }
    
    XCTAssertTrue(dummy.id == result.id)
    XCTAssertTrue(dummy.title == result.title)
  }
  
  func test_기존의데이터를덮어씌우고다시가져왔을때동일한데이터가나와야한다() throws {
    // given
    let dummies = [
      DummyTestEntity(id: "1", title: "hi"),
      DummyTestEntity(id: "2", title: "bi")
    ]
    
    // when
    let observable = sut.upsert(entities: dummies)
      .flatMap {
        return self.sut.upsert(entities: [DummyTestEntity(id: "2", title: "hoho")])
      }
      .flatMap { _ -> Observable<[DummyTestEntity]> in
        let id = "2"
        let predicate = NSPredicate(format: "id == %@", id)
        return self.sut.fetch(with: predicate, sortDescriptors: nil, limit: 1)
      }
      .compactMap {
        $0.first
      }

    // then
    guard let result = try observable.toBlocking().first() else {
      XCTFail("Fail")
      return
    }
    
    XCTAssertTrue(dummies.last?.id == result.id)
    XCTAssertTrue("hoho" == result.title)
  }
  
  func test_데이터를가져올때원하는정렬방식으로가져와야한다() throws {
    // given
    let dummies = [
      DummyTestEntity(id: "3", title: "ci"),
      DummyTestEntity(id: "2", title: "bi"),
      DummyTestEntity(id: "1", title: "hi")
    ]
    
    // when
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
    let observable: Observable<[DummyTestEntity]> = sut.fetch(with: nil, sortDescriptors: [sortDescriptor], limit: nil)

    // then
    guard let result = try observable.toBlocking().first() else {
      XCTFail("Fail")
      return
    }
    
    for index in result.indices {
      XCTAssertTrue(index.description == result[index].id)
    }
  }
  
  func test_동일한id의데이터만삭제되어야한다() throws {
    // given
    let deleteData = DummyTestEntity(id: "2", title: "bi")
    let dummies = [
      deleteData,
      DummyTestEntity(id: "1", title: "hi")
    ]
    
    // when
    let observable = sut.upsert(entities: dummies)
      .flatMap {
        return self.sut.delete(entity: deleteData)
      }
      .flatMap { _ -> Observable<[DummyTestEntity]> in
        return self.sut.fetch(with: nil, sortDescriptors: nil, limit: nil)
      }
    
    // then
    guard let result = try observable.toBlocking().first() else {
      XCTFail("Fail")
      return
    }
    
    XCTAssertTrue(result.count == 1)
    XCTAssertTrue(result.first?.id == "1")
    XCTAssertTrue(result.first?.title == "hi")
  }
  
  // MARK: Private Test Helper
  private func deleteAll(dispatchGroup: DispatchGroup) {
    StubCoreDataWorker.default.performBackgroundTask { context in
      let request = DummyTest.fetchRequest()
      do {
        let data = try context.fetch(request)
        data.forEach {
          context.delete($0)
        }
        try context.save()
        dispatchGroup.leave()
      } catch {
        XCTFail("삭제 실패")
      }
    }
  }
}
