//
//  DrawingViewController.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 12.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var drawView: AnyObject!
    let colorPicker = HSBColorPicker()

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func colorTapped(button: UIButton!) {
        let theDrawView = drawView as! DrawView
        var color: UIColor!
        if (button.titleLabel?.text == "Красный") {
            color = UIColor.red
        } else if (button.titleLabel?.text == "Черный") {
            color = UIColor.black
        }
        theDrawView.drawColor = color
    }

    @IBAction func onColorPickerClick(_ sender: Any) {
        let popController = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "popover")
        
        popController.modalPresentationStyle = UIModalPresentationStyle.popover
        
        popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = sender as? UIView
        popController.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
        
        self.present(popController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
