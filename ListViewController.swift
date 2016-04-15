//
//  ListViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 31/3/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var notesTable: UITableView!
    var arrayNotes: [Note]!
    var searchedNotes:[Note] = []
    var selectedNote: Note!
    var isSearching = false{
        didSet{
            notesTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "view"{
            if let vc = segue.destinationViewController as? AddNoteViewController{
                vc.note = selectedNote
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
        //self.performSegueWithIdentifier("view", sender: self)
    }
    
    //MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchedNotes = []
        isSearching = true
        
        var searchText = searchBar.text ?? ""
        if searchText.isEmpty == false{
            isSearching = true
            
            searchedNotes = []
            
            for note in arrayNotes{
                let noteTitle = note.title.lowercaseString
                searchText = searchText.lowercaseString
                if noteTitle.containsString(searchText){
                    searchedNotes.append(note)
                }
            }
            notesTable.reloadData()
            
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var searchText = searchBar.text ?? ""
        if searchText.isEmpty == false{
            isSearching = true
            
            searchedNotes = []
            
            for note in arrayNotes{
                let noteTitle = note.title.lowercaseString
                searchText = searchText.lowercaseString
                if noteTitle.containsString(searchText){
                    searchedNotes.append(note)
                }
            }
            notesTable.reloadData()
            
        }/*else{
            isSearching = false
        }*/
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
