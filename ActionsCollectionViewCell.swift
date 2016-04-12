//
//  ActionsCollectionViewCell.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 31/3/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

class ActionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var actionName: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    
    var actionItem: Actions! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        actionImage.image = actionItem.image
        actionName.text = actionItem.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
}
