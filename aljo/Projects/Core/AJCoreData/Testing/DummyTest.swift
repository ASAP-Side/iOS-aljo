//
//  DummyTest.swift
//  AJCoreDataTesting
//
//  Created by 이태영 on 2/3/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import AJCoreDataInterface
import CoreData

extension DummyTest: ManageObjectProtocol {
  public func toEntity() -> DummyTestEntity? {
    return DummyTestEntity(id: id ?? "", title: title ?? "")
  }
}

public struct DummyTestEntity: ManagedObjectConvertible {
  let id: String
  let title: String
  
  public func toManagedObject(in context: NSManagedObjectContext) -> DummyTest {
    let dummyTest = DummyTest.fetchSingle(with: id, from: context)
    
    dummyTest.id = id
    dummyTest.title = title
    
    return dummyTest
  }
}
