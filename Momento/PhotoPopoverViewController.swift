//
//  PhotoPopoverViewController.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 13.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class PhotoPopoverViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var transperentMonitor: UILabel!
    @IBOutlet weak var transperentSlider: UISlider!
    @IBOutlet weak var mainView: UIView!
    
    private let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showPopUpAnimation()
        
        mainView.layer.cornerRadius = 10
        
        let drawingVC = parent as! DrawingViewController
        transperentSlider.value = Float(drawingVC.photoImageView.alpha)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let drawingVC = parent as! DrawingViewController
        drawingVC.photoImageView.contentMode = .scaleAspectFit
        drawingVC.photoImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onPickPhotoClick(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func transperentChanched(_ sender: UISlider) {
        let drawingVC = self.parent as! DrawingViewController
        drawingVC.photoImageView.alpha = CGFloat(sender.value)
    }
    @IBAction func onCloseClick(_ sender: Any) {
        self.removePopUpAnimation()
    }
}
