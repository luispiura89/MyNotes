//
//  CDObject.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 6/6/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit
import CoreData

class CDObject: NSManagedObject {
    init() {
        let context = DataManager.managedObjectContext
        let entity = NSEntityDescription.insertNewObjectForEntityForName(String(self.dynamicType), inManagedObjectContext: context)
        
        super.init(entity: entity.entity, insertIntoManagedObjectContext: entity.managedObjectContext)
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func save() {
        let context = DataManager.managedObjectContext
        do {
            try context.save()
        } catch {
            
        }
    }
}
