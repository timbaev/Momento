//
//  DetailViewController.swift
//  Momento
//
//  Created by Elina on 13/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var descriptionTextView: UITextView!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    var text: String = ""
    var image: UIImage!
    var descriptionText: String = ""
    
    var folderIndex: Int! //индекс папки
    var indexInFolder: Int! //индекс картинки в папке
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = text
        imageView.image = image
        descriptionLabel.text = descriptionText
        
        textLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.isHidden = true
        titleTextField.layer.borderColor = UIColor.lightGray.cgColor
        titleTextField.layer.cornerRadius = 5
        
        
        let touch  = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        
        view.addGestureRecognizer(touch)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    func endEditing() {
        self.view.endEditing(true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if (editing) {
            textLabel.isHidden = true
            titleTextField.isHidden = false
            titleTextField.text = textLabel.text
            
            descriptionLabel.isHidden = true
            descriptionTextView.isHidden = false
            descriptionTextView.text = descriptionLabel.text
        } else {
            textLabel.isHidden = false
            titleTextField.isHidden = true
            textLabel.text = titleTextField.text
            textLabel.sizeToFit()
            
            descriptionLabel.isHidden = false
            descriptionTextView.isHidden = true
            descriptionLabel.text = descriptionTextView.text
            descriptionLabel.sizeToFit()
        
            DatabaseModel.instance.data[folderIndex].cellsArray[indexInFolder].cellText = textLabel.text!
            DatabaseModel.instance.data[folderIndex].cellsArray[indexInFolder].cellDescription = descriptionLabel.text!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveToTrash(_ sender: Any) {
        
        
    }
    
}
