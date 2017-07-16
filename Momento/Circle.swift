//
//  Circle.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 16.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import Foundation

class Circle {
    var center: CGPoint
    var lineWidth: Int
    var radius: CGFloat
    var color: UIColor
    let endAngle: CGFloat = CGFloat(2 * M_PI)
    
    init(center: CGPoint, lineWidth: Int, radius: CGFloat, color: UIColor) {
        self.center = center
        self.lineWidth = lineWidth
        self.radius = radius
        self.color = color
    }
}
