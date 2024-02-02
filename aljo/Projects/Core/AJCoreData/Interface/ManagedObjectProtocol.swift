//
//  ManagedObjectProtocol.swift
//  AJCoreDataInterface
//
//  Created by 이태영 on 2/2/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import CoreData

protocol ManageObjectProtocol {
  associatedtype Entity
  func toEntity() -> Entity?
}

extension ManageObjectProtocol where Self: NSManagedObject {
  static func fetchSingle(with id: String, from context: NSManagedObjectContext) -> Self {
    let request = Self.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id)
    request.fetchLimit = 1
    
    guard let result = try? context.fetch(request).first as? Self else {
      return Self(context: context)
    }
    
    return result
  }
}
