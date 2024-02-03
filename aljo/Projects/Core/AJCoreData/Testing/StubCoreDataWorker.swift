//
//  StubCoreDataWorker.swift
//  AJCoreDataTesting
//
//  Created by 이태영 on 2/3/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import CoreData

public final class StubCoreDataWorker {
  public static let `default` = StubCoreDataWorker()
  
  private let persistentContainer: NSPersistentContainer
  
  private init() {
    self.persistentContainer = {
      let container = NSPersistentContainer(name: "TEST")
      
      container.loadPersistentStores { description, error in
        if let error = error {
          assert(false, "코어데이터를 저장소를 불러오지 못했습니다.")
        }
      }
      
      return container
    }()
    
    let description = NSPersistentStoreDescription()
    description.url = URL(fileURLWithPath: "/dev/null")
    self.persistentContainer.persistentStoreDescriptions = [description]
  }
  
  func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
    persistentContainer.performBackgroundTask(block)
  }
}
