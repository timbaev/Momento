//
//  DrawingViewController.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 12.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet var drawView: AnyObject!
    @IBOutlet weak var photoImageView: UIImageView!
    let colorPicker = HSBColorPicker()
    var barButtonColor: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        barButtonColor = UIBarButtonItem(title: "Кисть", style: .plain, target: self, action: #selector(onColorPickerClick(_:)))
        navigationItem.rightBarButtonItem = barButtonColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearTapped() {
        let theDrawView = drawView as! DrawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }
    
    @IBAction func onCancelLineClick(_ sender: Any) {
        let theDrawView = drawView as! DrawView
        if (theDrawView.lines.count > 0) {
            theDrawView.lines.remove(at: theDrawView.lines.count - 1)
            theDrawView.setNeedsDisplay()
        }
    }
    
    @IBAction func onPickPhotoClick(_ sender: Any) {
        showPopUp(with: "photoPopUp")
    }
    

    @IBAction func onColorPickerClick(_ sender: Any) {
        showPopUp(with: "colorPopover")
    }
    
    private func showPopUp(with name: String) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func onSaveImageClick(_ sender: Any) {
        let drawView = self.drawView as! UIView
        UIGraphicsBeginImageContext(drawView.frame.size)
        drawView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
}
