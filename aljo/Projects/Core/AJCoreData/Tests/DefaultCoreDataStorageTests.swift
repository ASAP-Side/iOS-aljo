import XCTest
@testable import AJCoreDataImplemenetation
@testable import AJCoreDataTesting

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
  func test_새로운데이터를넣고다시가져왔을때동일한id의데이터가나와야한다() {
    // given
    let dummy = DummyTestEntity(id: "1", title: "hi")
    let expectation = XCTestExpectation(description: "DefaultCoreDataStorageTest")
    
    // when
    var result: DummyTestEntity?
    sut.upsert(entities: [dummy])
      .flatMap { _ -> Observable<[DummyTestEntity]> in
        return self.sut.fetch(with: nil, sortDescriptors: nil, limit: 1)
      }
      .compactMap {
        $0.first
      }
      .subscribe(onNext: {
        result = $0
        expectation.fulfill()
      }, onError: {
        XCTFail($0.localizedDescription)
      })
      .disposed(by: disposeBag)
    
    // then
    wait(for: [expectation], timeout: 5.0)
    XCTAssertTrue(dummy.id == result?.id)
    XCTAssertTrue(dummy.title == result?.title)
  }
  
  func test_기존의데이터를덮어씌우고다시가져왔을때동일한데이터가나와야한다() {
    // given
    let dummies = [
      DummyTestEntity(id: "1", title: "hi"),
      DummyTestEntity(id: "2", title: "bi")
    ]
    let expectation = XCTestExpectation(description: "DefaultCoreDataStorageTest")
    
    // when
    sut.upsert(entities: dummies)
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
      .subscribe(onNext: {
        XCTAssertTrue(dummies.last?.id == $0.id)
        XCTAssertTrue("hoho" == $0.title)
        expectation.fulfill()
      }, onError: {
        XCTFail($0.localizedDescription)
      })
      .disposed(by: disposeBag)
    
    // then
    wait(for: [expectation], timeout: 5.0)
  }
  
  func test_데이터를가져올때원하는정렬방식으로가져와야한다() {
    // given
    let dummies = [
      DummyTestEntity(id: "3", title: "ci"),
      DummyTestEntity(id: "2", title: "bi"),
      DummyTestEntity(id: "1", title: "hi")
    ]
    
    let expectation = XCTestExpectation(description: "DefaultCoreDataStorageTest")
    
    // when
    var result: [DummyTestEntity] = []
    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
    sut.fetch(with: nil, sortDescriptors: [sortDescriptor], limit: nil)
      .subscribe(onNext: {
        result = $0
        expectation.fulfill()
      }, onError: {
        XCTFail($0.localizedDescription)
      })
      .disposed(by: disposeBag)
    
    // then
    wait(for: [expectation], timeout: 5.0)

    for index in result.indices {
      XCTAssertTrue(index.description == result[index].id)
    }
  }
  
  func test_동일한id의데이터만삭제되어야한다() {
    // given
    let deleteData = DummyTestEntity(id: "2", title: "bi")
    let dummies = [
      deleteData,
      DummyTestEntity(id: "1", title: "hi")
    ]
    
    let expectation = XCTestExpectation(description: "DefaultCoreDataStorageTest")
    
    // when
    sut.upsert(entities: dummies)
      .flatMap {
        return self.sut.delete(entity: deleteData)
      }
      .flatMap { _ -> Observable<[DummyTestEntity]> in
        return self.sut.fetch(with: nil, sortDescriptors: nil, limit: nil)
      }
      .subscribe(onNext: {
        XCTAssertTrue($0.count == 1)
        XCTAssertTrue($0.first?.id == "1")
        XCTAssertTrue($0.first?.title == "hi")
        expectation.fulfill()
      }, onError: {
        XCTFail($0.localizedDescription)
      })
      .disposed(by: disposeBag)
      
    wait(for: [expectation], timeout: 5.0)
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
