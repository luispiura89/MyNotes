//
//  ListViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 31/3/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ActivityEnded{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var notesTable: UITableView!
    var arrayNotes = [Note]()
    var searchedNotes:[Note] = []
    var selectedNote: Note!
    var isSearching = false{
        didSet{
            notesTable.reloadData()
        }
    }
    
    var editingTable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let query = Query(className: Note.ClassName)
        query.descending("date")
        query.equalTo("finished", value: NSNumber(bool: false))
        if let results = query.find() as? [Note]{
            arrayNotes = results
            notesTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }


    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "view"{
            if let vc = segue.destinationViewController as? AddNoteViewController{
                vc.note = selectedNote
                vc.delegate = self
            }
        }
    }
    
    
    //MARK: - TableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching == false ? arrayNotes.count : searchedNotes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell")!
        
        if let cell = cell as? NoteTableViewCell{
            cell.note = isSearching == false ? arrayNotes[indexPath.item] : searchedNotes[indexPath.item]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let note = isSearching == false ? arrayNotes[indexPath.row] : searchedNotes[indexPath.row]
        selectedNote = note
        performSegueWithIdentifier("view", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let context = DataManager.managedObjectContext
            var selectedNote: Note!
            
            if !isSearching{
                selectedNote = arrayNotes[indexPath.row]
            }else{
                selectedNote = searchedNotes[indexPath.row]
            }
            
            context.deleteObject(selectedNote)
            do{
                try context.save()
                
                if !isSearching{
                    arrayNotes.removeAtIndex(indexPath.row)
                }else{
                    let index = arrayNotes.indexOf(selectedNote)
                    if let index = index{
                        arrayNotes.removeAtIndex(index)
                    }
                    searchedNotes.removeAtIndex(indexPath.row)
                }
                notesTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }catch{
                
            }
        }
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        var searchText = searchBar.text ?? ""
        if searchText.isEmpty == false{
            isSearching = true
            
            searchedNotes = []
            searchText = searchText.lowercaseString
            let query = Query(className: Note.ClassName)
            query.descending("date")
            query.equalTo("finished", value: NSNumber(bool: false))
            query.contains("title", substring: searchText)
            
            if let results = query.find() as? [Note]{
                searchedNotes = results
            }
            
            notesTable.reloadData()
            
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var searchText = searchBar.text ?? ""
        if searchText.isEmpty == false{
            isSearching = true
            
            searchedNotes = []
            searchText = searchText.lowercaseString
            let query = Query(className: Note.ClassName)
            query.descending("date")
            query.equalTo("finished", value: NSNumber(bool: false))
            query.contains("title", substring: searchText)
            
            if let results = query.find() as? [Note]{
                searchedNotes = results
            }
            
            notesTable.reloadData()
            
        }
    
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    //MARK: - ActivityEnded
    func activityEnded() {
        let query = Query(className: Note.ClassName)
        query.descending("date")
        query.equalTo("finished", value: NSNumber(bool: false))
        if isSearching{
            if let text = searchBar.text{
                query.contains("title", substring: text)
            }
        }
        if let results = query.find() as? [Note]{
            if isSearching{
                searchedNotes = results
                
                let allNotesQuery = Query(className: Note.ClassName)
                allNotesQuery.descending("date")
                allNotesQuery.equalTo("finished", value: NSNumber(bool: false))
                
                if let allNotes = allNotesQuery.find() as? [Note]{
                    arrayNotes = allNotes
                }
            }else{
                arrayNotes = results
            }
            notesTable.reloadData()
        }
    }
    
    //MARK: - Actions

    @IBAction func editTableAction(sender: AnyObject) {
        if !isSearching{
            notesTable.editing = !notesTable.editing
            editingTable = notesTable.editing
            editButton.title = editingTable ? "Done" : "Edit"
        }
    }
}
