//
//  Actions.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 31/3/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

class Actions: NSObject {
    var image: UIImage
    var name: String
    var id: String
    
    init(image: UIImage, name: String, id: String){
        self.name = name
        self.image = image
        self.id = id
    }
    
    static func getActions() -> [Actions]{
        return [Actions(image: UIImage(named: "addIcon")!, name: "Add Note", id: "write"),
            Actions(image: UIImage(named: "searchIcon")!, name: "Search Note", id: "search")]
    }
}
