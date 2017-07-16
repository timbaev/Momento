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
    
    var isLineColorChange = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showPopUpAnimation()
        
        mainView.layer.cornerRadius = 10
        
        colorPicker.delegate = self
        
        colorMonitor.layer.borderWidth = 1
        colorMonitor.layer.borderColor = UIColor.black.cgColor
        if (isLineColorChange) {
            colorMonitor.backgroundColor = getDrawView().drawColor
        } else {
            colorMonitor.backgroundColor = getDrawView().fillColor
        }
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.removePopUpAnimation()
    }
    
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizerState) {
        colorMonitor.backgroundColor = color
        let drawingVC = self.parent as! DrawingViewController
        let drawView = drawingVC.drawView as! DrawView
        if (isLineColorChange) {
            drawView.drawColor = color
        } else {
            drawView.fillColor = color
        }
    }
    
    func getDrawView() -> DrawView {
        let drawingVC = self.parent as! DrawingViewController
        let drawView = drawingVC.drawView as! DrawView
        return drawView
    }
}
