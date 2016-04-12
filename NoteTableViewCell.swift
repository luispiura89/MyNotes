//
//  NoteTableViewCell.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 2/4/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteImageView: UIView!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    
    var note: Note!{
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(){
        titleLabel.text = note.title
        dateLabel.text = note.date.description
        if note.priority == .normal{
            priorityLabel.text = "Normal"
        }else{
            priorityLabel.text = "Urgent"
            titleLabel.textColor = UIColor.whiteColor()
            priorityLabel.textColor = UIColor.whiteColor()
            dateLabel.textColor = UIColor.whiteColor()
            self.backgroundColor = UIColor(red: 159/255, green: 105/255, blue: 113/255, alpha: 1.0)
            
        }
        noteImage.image = note.image
    }

}
