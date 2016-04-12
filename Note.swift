//
//  Note.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 1/4/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

enum priorityType{
    case normal, urgent
}

class Note: NSObject {
    var title: String
    var body: String
    var priority: priorityType
    var date: NSDate
    var priorityRange: Float
    var image: UIImage
    
    init(title: String, body: String, priority: priorityType, priorityRange: Float) {
        self.title = title
        self.body = body
        self.priority = priority
        self.date = NSDate()
        self.priorityRange = priorityRange
        self.image = UIImage(named: "thumbnail")!
    }
    
}
