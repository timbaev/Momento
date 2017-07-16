//
//  Figure.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 16.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import Foundation

protocol Figure {
    var lineWidth: CGFloat {get set}
    var color: UIColor {get set}
    var opacity: CGFloat {get set}
    
    func draw(with context: CGContext)
}
