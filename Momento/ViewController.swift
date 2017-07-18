//
//  ViewController.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 11.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var mainLabel: UILabel!
    var firstLaunch = true
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addParallax()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (firstLaunch) {
            mainLabel.center.y -= 200
            mainLabel.alpha = 0
            UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: {
                self.mainLabel.center.y += 200
                self.mainLabel.alpha = 1.0
                self.view.layoutIfNeeded()
            }, completion: nil)
            firstLaunch = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated:true)
    }
    
    func addParallax() {
        let amount = 50
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.view.addMotionEffect(group)
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
    
    func imageSavedMessage() {
        self.showToast(message: "Сохранено успешно!")
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

