//
//  AnimationPopUp.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 13.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showPopUpAnimation() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removePopUpAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        });
    }
}
