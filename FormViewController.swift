//
//  FormViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 2/4/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

protocol NoteAdded{
    func appendNote(note: Note)
}

class FormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,NoteWrited {

    var noteTitle: String!
    var noteBody: String!
    var notePriority: Float!
    var notePriorityType: priorityType!
    var noteImage: UIImage!
    
    var delegate: NoteAdded!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return 10
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
        self.dismissViewControllerAnimated(true) {
            
            if let priorityR = self.notePriority{
                if priorityR > 0.5{
                    self.notePriorityType = .urgent
                }else{
                    self.notePriorityType = .normal
                }
            }else{
                self.notePriority = 0.5
                self.notePriorityType = .normal
            }
            
            self.noteTitle = self.noteTitle ?? ""
            self.noteBody = self.noteBody ?? ""
            self.noteImage = self.noteImage ?? UIImage(named: "thumbnail")
            
            let note = Note(title: self.noteTitle, body: self.noteBody, priority: self.notePriorityType, priorityRange: self.notePriority)
            note.image = self.noteImage
            self.delegate.appendNote(note)
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
    

}
