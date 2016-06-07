//
//  AddNoteViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 31/3/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

protocol ActivityEnded {
    func activityEnded()
}

class AddNoteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var note: Note!
    var delegate: ActivityEnded!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = note.title
        bodyTextView.text = note.body
        dateLabel.text = note.date!.description
        if let image = note.image{
            iconImageView.image = UIImage(data: image)
            iconImageView.layer.masksToBounds = true
            iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - TextFieldDelegate
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Actions
    @IBAction func backAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    @IBAction func doneActivity(sender: AnyObject) {
        if let note = note{
            note.finished = NSNumber(bool: true)
            note.save()
            self.dismissViewControllerAnimated(true, completion: {
                self.delegate.activityEnded()
            })
        }
    }
    
    

    
    

}
