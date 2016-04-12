//
//  WriteViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 1/4/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

protocol WriteNoteDelegate{
    func noteWrited(note: Note)
}

class WriteViewController: UIViewController{
    
    @IBOutlet weak var prioritySlideBar: UISlider!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var priorityValue: Float!
    var noteTitle: String!
    var noteBody: String!
    var noteMode: priorityType!
    
    var writeNoteDelegate: WriteNoteDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageLabel.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            () -> Void in
        }
    }
    
    @IBAction func saveNote(sender: AnyObject) {
        self.noteTitle = self.titleTextField.text!
        self.noteBody = self.bodyTextView.text!
        
        if self.noteTitle != "" && self.noteBody != ""{
            self.dismissViewControllerAnimated(true) { () -> Void in
                self.priorityValue = self.prioritySlideBar.value
            
                if self.priorityValue > 0.5{
                    self.noteMode = priorityType.urgent
                }else{
                    self.noteMode = priorityType.normal
                }
            
                let note: Note = Note(title: self.noteTitle, body: self.noteBody,
                                      priority: self.noteMode, priorityRange: self.priorityValue)
                
                self.writeNoteDelegate.noteWrited(note)
            
                
            }
        }else{
            self.errorMessageLabel.text = "Fill the required fields"
        }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
