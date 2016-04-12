//
//  FormTableViewCell.swift
//  MyNotes
//
//  Created by Luis Francisco Piura Mejia on 2/4/16.
//  Copyright © 2016 Luis Francisco Piura Mejia. All rights reserved.
//

import UIKit

protocol NoteWrited{
    func bodyWrited(body: String)
    func titleWrited(title: String)
    func prioritySeted(priority: Float)
    func searchImage(picker: UIImagePickerController)
    func imageSelected(image: UIImage, picker: UIImagePickerController)
}

class FormTableViewCell: UITableViewCell, UITextViewDelegate,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var cellIdentifier: String!{
        didSet{
            if cellIdentifier == "titleCell"{
                titleTextField.delegate = self
            }else if cellIdentifier == "contentCell"{
                bodyTextView.delegate = self
            }else if cellIdentifier == "iconCell"{
                imagePicker.delegate = self
            }
        }
    }
    
    var delegate: NoteWrited!
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var prioritySlideBar: UISlider!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Note Information
    
    @IBAction func setPriority(sender: AnyObject) {
        //if cellIdentifier == "imageCell"{
        //    self.delegate.prioritySeted(prioritySlideBar.value)
        //}
        self.delegate.prioritySeted(prioritySlideBar.value)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.delegate.titleWrited(titleTextField.text!)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textViewDidChange(textView: UITextView) {
        self.delegate.bodyWrited(bodyTextView.text!)
    }
    
    //MARK: - Image Selection

    @IBAction func loadImage(sender: AnyObject) {
        self.delegate.searchImage(imagePicker)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            iconImage.image = pickedImage
            iconImage.contentMode = .ScaleAspectFill
            self.delegate.imageSelected(pickedImage, picker: picker)
        }
    }
    
    

    
    
}
