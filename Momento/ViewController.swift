//
//  ViewController.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 11.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openLibrary() {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "addPhotoSegue", sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addPhotoSegue") {
            let addPhotoVC = segue.destination as! AddPhotoViewController
            addPhotoVC.photo = sender as! UIImage
        }
    }

    @IBAction func onTakePhotoClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Take photo",
                                                message: "Just choose function",
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive)
        let addFromLibrary = UIAlertAction(title: "Library",
                                           style: .default ) { (_) in
                                            self.openLibrary()
        }
        let openCamera = UIAlertAction(title: "Take photo",
                                       style: .default) { (_) in
                                        self.takePhoto()
        }
        alertController.addAction(openCamera)
        alertController.addAction(addFromLibrary)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func onScanClick(_ sender: Any) {
        
    }
}

