//
//  Rectangle.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 16.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import Foundation

class Rectangle {
    var center: CGPoint
    var width: CGFloat
    var height: CGFloat
    var lineWidth: Int
    var strokeColor: UIColor
    var fillColor: UIColor
    
    init(center: CGPoint, width: CGFloat, height: CGFloat, lineWidth: Int, strokeColor: UIColor, fillColor: UIColor) {
        self.center = center
        self.width = width
        self.height = height
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.fillColor = fillColor
    }
}
