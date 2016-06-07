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
                iconImage.layer.masksToBounds = true
                iconImage.layer.cornerRadius = iconImage.frame.width / 2
                imagePicker.delegate = self
                loadImageButton.layer.borderWidth = 0.5
                loadImageButton.layer.cornerRadius = 5
                loadImageButton.layer.borderColor = loadImageButton.tintColor.CGColor
            }
        }
    }
    
    var delegate: NoteWrited!
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var prioritySlideBar: UISlider!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var loadImageButton: UIButton!
    
    
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
    
    //MARK: - ImagedPickedControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            iconImage.image = pickedImage
            iconImage.contentMode = .ScaleAspectFill
            self.delegate.imageSelected(pickedImage, picker: picker)
        }
    }
    
    

    
    
}
