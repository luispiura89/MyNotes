//
//  ViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 31/3/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NoteAdded {

    let actionsList = Actions.getActions()
    var selectedAction: NSIndexPath?
    var notesArray = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: - CollectionView DataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actionsList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Actions Cell", forIndexPath: indexPath) as! ActionsCollectionViewCell
        
        cell.actionItem = actionsList[indexPath.item]
        
        return cell
        
    }
    
    //MARK: - CollectionView Delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedAction = indexPath
        
        if let action = selectedAction{
            let actionId = actionsList[action.item].id
            
            
                self.performSegueWithIdentifier(actionId, sender: self)
            
        }
    }
    
    //MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "write"{
            if let vc = segue.destinationViewController as? FormNavigationController{
                vc.noteAdded = self
                //vc.writeNoteDelegate = self
            }
        }
        
        
        /*
        if segue.identifier == "search"{
            if let vc = segue.destinationViewController as? ListNavigationViewController{
                vc.arrayNotes = notesArray
            }
        }*/
        
    }
    
    //MARK: - NoteAdded
    
    func appendNote(note: Note) {
        notesArray.append(note)
    }
    
    

}

