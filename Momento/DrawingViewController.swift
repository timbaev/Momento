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
    @IBOutlet weak var traillingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    var barButtonColor: UIBarButtonItem!
    var menuShowing = false
    var isLineColorChange: Bool!
    var pickedButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        barButtonColor = UIBarButtonItem(image: #imageLiteral(resourceName: "palette"), style: .plain, target: self, action: #selector(self.onColorPickerClick(_:)))
        let barButtonDesigner = UIBarButtonItem(image: #imageLiteral(resourceName: "designer"), style: .plain, target: self, action: #selector(self.openMenu))
        navigationItem.rightBarButtonItem = barButtonDesigner
        navigationItem.rightBarButtonItems?.append(barButtonColor)
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.hideSideMenuTap(_:)))
        drawView.addGestureRecognizer(gesture)
        
        lineButton.layer.cornerRadius = 10
        lineButton.backgroundColor = UIColor.white
        pickedButton = lineButton
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func clearTapped() {
        let theDrawView = drawView as! DrawView
        theDrawView.figures = []
        theDrawView.setNeedsDisplay()
    }
    
    @IBAction func onCancelLineClick(_ sender: Any) {
        let theDrawView = drawView as! DrawView
        if (theDrawView.figures.count > 0) {
            theDrawView.figures.remove(at: theDrawView.figures.count - 1)
            theDrawView.setNeedsDisplay()
        }
    }
    
    @IBAction func onPickPhotoClick(_ sender: Any) {
        showPopUp(with: "photoPopUp")
    }
    

    @IBAction func onColorPickerClick(_ sender: UIButton) {
        isLineColorChange = true
        showPopUp(with: "colorPopover")
    }
    
    @IBAction func onFillColorPickerClick(_ sender: UIButton) {
        isLineColorChange = false
        showPopUp(with: "colorPopover")
    }
    
    private func showPopUp(with name: String) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
        if name == "colorPopover" {
            (popOverVC as! ColorPopoverViewController).isLineColorChange = isLineColorChange
        }
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveDrawSegue") {
            let drawView = self.drawView as! UIView
            UIGraphicsBeginImageContext(drawView.frame.size)
            drawView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            let addPhotoVC = segue.destination as! AddPhotoViewController
            addPhotoVC.photo = image
        }
    }
    
    //MARK: -
    //MARK: side menu
    
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var lineWidthSlider: UISlider!
    @IBOutlet weak var opacityMonitorLabel: UILabel!
    @IBOutlet weak var widthMonitorLabel: UILabel!
    @IBOutlet weak var lineButton: UIButton!
    
    @IBAction func opacityLineChanged(_ sender: UISlider) {
        let drawView = self.drawView as! DrawView
        drawView.opacity = CGFloat(sender.value)
        opacityMonitorLabel.text = String(sender.value)
    }
    
    @IBAction func lineWidthChanged(_ sender: UISlider) {
        let drawVeiw = self.drawView as! DrawView
        drawVeiw.lineWidth = Int(sender.value)
        widthMonitorLabel.text = String(Int(sender.value))
    }
    
    @IBAction func onFigureClick(_ sender: UIButton) {
        let castDrawView = self.drawView as! DrawView
        castDrawView.shape = sender.tag
        if (pickedButton != nil) {
            pickedButton.backgroundColor = UIColor.clear
        }
        pickedButton = sender
        sender.layer.cornerRadius = 10
        sender.backgroundColor = UIColor.white
    }
    
    @objc private func openMenu() {
        if (menuShowing) {
            traillingConstraint.constant = -290
        } else {
            traillingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    func hideSideMenuTap(_ sender: UITapGestureRecognizer) {
        if (menuShowing) {
            traillingConstraint.constant = -290
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuShowing = !menuShowing
    }
    
    
}
