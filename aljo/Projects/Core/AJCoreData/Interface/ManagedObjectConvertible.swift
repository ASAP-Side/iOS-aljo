//
//  ManagedObjectConvertible.swift
//  AJCoreDataInterface
//
//  Created by 이태영 on 2/2/24.
//  Copyright © 2024 com.ASAP. All rights reserved.
//

import CoreData

protocol ManagedObjectConvertible {
  associatedtype ManagedObject: NSManagedObject, ManageObjectProtocol
  
  func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject
}
