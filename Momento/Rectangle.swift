//
//  Rectangle.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 16.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import Foundation

class Rectangle: Figure {
    var center: CGPoint
    var width: CGFloat
    var height: CGFloat
    var lineWidth: CGFloat
    var color: UIColor
    var opacity: CGFloat
    var fillColor: UIColor
    
    init(center: CGPoint, width: CGFloat, height: CGFloat, lineWidth: CGFloat, color: UIColor, fillColor: UIColor, opacity: CGFloat) {
        self.center = center
        self.width = width
        self.height = height
        self.lineWidth = lineWidth
        self.color = color
        self.fillColor = fillColor
        self.opacity = opacity
    }
    
    func draw(with context: CGContext) {
        context.beginPath()
        context.setLineWidth(lineWidth)
        context.setStrokeColor(color.cgColor)
        context.setAlpha(opacity)
        let rectangle = CGRect(x: center.x, y: center.y, width: width, height: height)
        context.addRect(rectangle)
        context.strokePath()
        
        context.setFillColor(fillColor.cgColor)
        context.fill(rectangle)
    }
}
