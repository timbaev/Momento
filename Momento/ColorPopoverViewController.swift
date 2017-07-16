//
//  ColorPopoverViewController.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 13.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class ColorPopoverViewController: UIViewController, HSBColorPickerDelegate {
    
    @IBOutlet weak var colorPicker: HSBColorPicker!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var colorMonitor: UIView!
    @IBOutlet weak var mainView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showPopUpAnimation()
        
        mainView.layer.cornerRadius = 10
        
        colorPicker.delegate = self
        
        colorMonitor.backgroundColor = getDrawView().drawColor
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.removePopUpAnimation()
    }
    
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizerState) {
        colorMonitor.backgroundColor = color
        let drawingVC = self.parent as! DrawingViewController
        let drawView = drawingVC.drawView as! DrawView
        drawView.drawColor = color
    }
    
    func getDrawView() -> DrawView {
        let drawingVC = self.parent as! DrawingViewController
        let drawView = drawingVC.drawView as! DrawView
        return drawView
    }
}
