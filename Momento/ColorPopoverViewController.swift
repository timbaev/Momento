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
    @IBOutlet weak var lineWidthMonitor: UILabel!
    @IBOutlet weak var widthSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showPopUpAnimation()
        
        mainView.layer.cornerRadius = 10
        
        colorPicker.delegate = self
        
        lineWidthMonitor.text = String(getDrawView().lineWidth)
        widthSlider.value = Float(getDrawView().lineWidth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.removePopUpAnimation()
    }
    
    @IBAction func lineWidthChanched(_ sender: UISlider) {
        lineWidthMonitor.text = String(Int(sender.value))
        getDrawView().lineWidth = Int(sender.value)
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
