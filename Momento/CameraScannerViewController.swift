//
//  CameraScannerViewController.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 14.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class CameraScannerViewController: UIViewController {
    
    //MARK: -
    //MARK: View fields

    @IBOutlet weak var cameraViewController: IPDFCameraViewController!
    @IBOutlet weak var focusIndicator: UIImageView!
    
    //MARK: -
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraViewController.setupCameraView()
        self.cameraViewController.isBorderDetectionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cameraViewController.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: -
    //MARK: CameraVC Actions
    
    @IBAction func focusGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == .recognized {
            let location: CGPoint = sender.location(in: cameraViewController as UIView )
            focusIndicatorAnimate(to: location)
            cameraViewController.focus(at: location, completionHandler: {() -> Void in
                self.focusIndicatorAnimate(to: location)
            })
        }
    }
    
    func focusIndicatorAnimate(to targetPoint: CGPoint) {
        focusIndicator.center = targetPoint
        focusIndicator.alpha = 0.0
        focusIndicator.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
            self.focusIndicator.alpha = 1.0
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.4, animations: {() -> Void in
                self.focusIndicator.alpha = 0.0
            })
        })
    }
    
    @IBAction func borderDetectToggle(_ sender: Any) {
        let enable: Bool = !cameraViewController.isBorderDetectionEnabled
        change(sender as! UIButton, targetTitle: (enable) ? "CROP ON" : "CROP OFF", toStateEnabled: enable)
        cameraViewController.isBorderDetectionEnabled = enable
    }
    
    @IBAction func filterToggle(_ sender: Any) {
        let enable = cameraViewController.cameraViewType == IPDFCameraViewType.blackAndWhite
        cameraViewController.cameraViewType = (enable) ? IPDFCameraViewType.normal : IPDFCameraViewType.blackAndWhite
        change(sender as! UIButton, targetTitle: "FILTER W/B", toStateEnabled: !enable)
    }
    
    @IBAction func tourchToggle(_ sender: Any) {
        let enable: Bool = !cameraViewController.isTorchEnabled
        change(sender as! UIButton, targetTitle: (enable) ? "FLASH ON" : "FLASH OFF", toStateEnabled: enable)
        cameraViewController.isTorchEnabled = enable
    }

    func change(_ button: UIButton, targetTitle title: String, toStateEnabled enabled: Bool) {
        button.setTitle(title, for: .normal)
        button.setTitleColor((enabled) ? UIColor(red: 1, green: 0.81, blue: 0, alpha: 1) : UIColor.white, for: .normal)
    }
    
    @IBAction func onCloseClick(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: -
    //MARK: CameraVC Capture Image

    @IBAction func captureButton(_ sender: Any) {
        weak var weakSelf = self
        self.cameraViewController.captureImage(completionHander: {(imageFilePath: String?) -> Void in
            
            let captureImageView = UIImageView(image: UIImage(contentsOfFile: imageFilePath!)!)
            captureImageView.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
            captureImageView.frame = weakSelf!.view.bounds.offsetBy(dx: 0, dy: -weakSelf!.view.bounds.size.height)
            captureImageView.alpha = 1.0
            captureImageView.contentMode = .scaleAspectFit
            captureImageView.isUserInteractionEnabled = true
            weakSelf!.view.addSubview(captureImageView)
            let dismissTap = UITapGestureRecognizer(target: weakSelf, action: #selector(self.dismissPreview))
            captureImageView.addGestureRecognizer(dismissTap)
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: .allowUserInteraction, animations: {() -> Void in
                captureImageView.frame = weakSelf!.view.bounds
            }, completion: { _ in })
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTakedPhotoSegue" {
            self.cameraViewController.captureImage(completionHander: {(imageFilePath: String?) -> Void in
                let capturedImage = UIImage(contentsOfFile: imageFilePath!)
                let addPhotoVC = segue.destination as! AddPhotoViewController
                addPhotoVC.photo = capturedImage
                addPhotoVC.setScannedImage()
            })
        }
    }
    
    func dismissPreview(dismissTap: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {() -> Void in
            dismissTap.view?.frame = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height)}, completion: {(_ finished: Bool) -> Void in
                dismissTap.view?.removeFromSuperview()
        })
    }
    
}
