//
//  ViewControllerTakePhoto.swift
//  Momento
//
//  Created by itisioslab on 13.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class ViewControllerTakePhoto: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var placeHolderImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - image picker controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            
            let alert = UIAlertController(title: "Hey", message: "You Don't made a photo!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default,handler: nil))
           
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        imagePicked.image = image
        placeHolderImageView.isHidden = true
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - open camera button
    
    @IBAction func openCameraPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    //MARK: - open library button
    
    @IBAction func openLibraryPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    //MARK: - save button
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard imagePicked.image != nil  else {
            let alert = UIAlertController(title: "Hey", message: "You Don't made a photo!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        let alert = UIAlertController(title: "Wow", message: "You have saved your photo", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default,handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    }

