//
//  AddPhotoViewController.swift
//  Momento
//
//  Created by itisioslab on 17.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var edgingView: UIView!
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    var photo: UIImage!
    
    
    @IBOutlet var caption: UITextField!
    
    @IBOutlet var descriptionSaving: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photo
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePhoto))
        self.navigationItem.rightBarButtonItem = saveButton
        
        let touch  = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        
        view.addGestureRecognizer(touch)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddPhotoViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddPhotoViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        edgingView.layer.cornerRadius = 10
        edgingView.backgroundColor = UIColor.white
        
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.delegate = self
        descriptionTextView.text = "Описание"
        descriptionTextView.textColor = UIColor.lightGray
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setScannedImage() {
        photoImageView.image = photo
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Описание"
            textView.textColor = UIColor.lightGray
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func savePhoto() {
        performSegue(withIdentifier: "pickCollectionSegue", sender: photo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pickCollectionSegue" && sender != nil) {
            let pickerCollectionVC = segue.destination as! PickerCollectionViewController
            pickerCollectionVC.image = sender as! UIImage
            pickerCollectionVC.text = caption.text!
            pickerCollectionVC.descriptionText = descriptionSaving.text
        }
        
    }
    
}
