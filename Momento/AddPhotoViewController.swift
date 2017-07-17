//
//  AddPhotoViewController.swift
//  Momento
//
//  Created by itisioslab on 17.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {

    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photo
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePhoto))
        self.navigationItem.rightBarButtonItem = saveButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func savePhoto() {
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        let alert = UIAlertController(title: "Wow", message: "You have saved your photo", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.default,handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
