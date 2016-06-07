//
//  Note+CoreDataProperties.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 7/6/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Note {

    @NSManaged var body: String?
    @NSManaged var date: NSDate?
    @NSManaged var image: NSData?
    @NSManaged var priority: NSNumber?
    @NSManaged var priorityRange: NSNumber?
    @NSManaged var title: String?
    @NSManaged var finished: NSNumber?

}
