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
    
    var text: String = ""
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = text
        imageView.image = image
        
        textLabel.sizeToFit()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
