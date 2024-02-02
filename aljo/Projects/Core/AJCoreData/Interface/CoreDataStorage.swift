//
//  CoreDataStorage.swift
//  AJCoreDataInterface
//
//  Created by 이태영 on 2/2/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import CoreData

import RxSwift

public protocol CoreDataStorage {
  func fetch<Entity: ManagedObjectConvertible>(
    with predicate: NSPredicate?,
    sortDescriptors: [NSSortDescriptor]?,
    limit: Int?
  ) -> Observable<[Entity]>
  
  func upsert<Entity: ManagedObjectConvertible>(entities: [Entity]) -> Observable<Void>
  
  func delete<Entity: ManagedObjectConvertible>(entity: Entity) -> Observable<Void>
}
