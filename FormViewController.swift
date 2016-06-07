//
//  FormViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 2/4/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit
import CoreData

protocol NoteAdded{
    func appendNote(note: Note)
}

class FormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,NoteWrited {

    var noteTitle: String!
    var noteBody: String!
    var notePriority: Float!
    var notePriorityType: priorityType!
    var noteImage: UIImage!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var error: UILabel!
    var delegate: NoteAdded!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        error.hidden = true
        error.text = ""
        topConstraint.constant = 0
        bottomConstraint.constant = 0
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
    
    //MARK: - TableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "titleCell" : indexPath.row == 1 ? "imageCell" : indexPath.row == 2 ? "contentCell" : "iconCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! FormTableViewCell
        
        cell.cellIdentifier = identifier
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row == 0 ? 60 : indexPath.row == 1 ? 60 : 165
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //MARK: - NoteWrited
    func titleWrited(title: String) {
        noteTitle = title    }
    
    func bodyWrited(body: String) {
        noteBody = body
    }
    
    func prioritySeted(priority: Float) {
        notePriority = priority
    }
    
    func searchImage(picker: UIImagePickerController){
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true) { 
            
        }
    }
    
    func imageSelected(image: UIImage, picker: UIImagePickerController) {
        noteImage = image
        picker.dismissViewControllerAnimated(true) { 
            
        }
    }
    
    //MARK: - Buttons
    
    @IBAction func saveNote(sender: AnyObject) {
        
        
        self.noteTitle = self.noteTitle ?? ""
        self.noteBody = self.noteBody ?? ""
        self.noteImage = self.noteImage ?? UIImage(named: "thumbnail")
        self.notePriority = self.notePriority ?? 0.5
        
        self.noteTitle = self.noteTitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.noteBody = self.noteBody.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        if !self.noteTitle.isEmpty && !self.noteBody.isEmpty{
            self.dismissViewControllerAnimated(true) {
                var urgentNote = false
                if self.notePriority > 0.5{
                    self.notePriorityType = .urgent
                    urgentNote = true
                }else{
                    urgentNote = false
                    self.notePriorityType = .normal
                }
                
                let context = DataManager.managedObjectContext
                
                let newNote = NSEntityDescription.insertNewObjectForEntityForName(Note.ClassName, inManagedObjectContext: context) as! Note
                
                newNote.title = self.noteTitle
                newNote.body = self.noteBody
                newNote.date = NSDate()
                newNote.priorityRange = NSNumber(float: self.notePriority)
                newNote.priority = NSNumber(bool: urgentNote)
                newNote.image = UIImageJPEGRepresentation(self.noteImage, 1.0)
                newNote.save()
            }
        }else{
            topConstraint.constant = 16
            bottomConstraint.constant = 13
            error.hidden = false
            error.text = "Fill require fields"
            let userLabelX = error.center.x
            error.center.x = error.center.x + 10
            
            UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 100, options: .CurveEaseOut, animations: {
                

                
                self.error.center.x = userLabelX
                
                
                }, completion: { (complete:Bool) in
                    
            })
            
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    

}
