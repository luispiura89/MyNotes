//
//  WriteNoteNavigationViewController.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 1/4/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

class WriteNoteNavigationViewController: UINavigationController {
    
    var writeNoteDelegate: WriteNoteDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let vc = self.topViewController as?WriteViewController{
            vc.writeNoteDelegate = self.writeNoteDelegate
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

}
