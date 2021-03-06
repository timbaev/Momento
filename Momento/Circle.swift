//
//  Circle.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 16.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import Foundation

class Circle: Figure {
    var center: CGPoint
    var lineWidth: CGFloat
    var radius: CGFloat
    var color: UIColor
    var opacity: CGFloat
    var fillColor: UIColor
    let endAngle: CGFloat = CGFloat(2 * M_PI)
    
    init(center: CGPoint, lineWidth: CGFloat, radius: CGFloat, color: UIColor, fillColor: UIColor, opacity: CGFloat) {
        self.center = center
        self.lineWidth = lineWidth
        self.radius = radius
        self.color = color
        self.fillColor = fillColor
        self.opacity = opacity
    }
    
    func draw(with context: CGContext) {
        context.beginPath()
        context.setLineWidth(CGFloat(lineWidth))
        context.setStrokeColor(color.cgColor)
        context.setAlpha(opacity)
        let rectangle = CGRect(x: center.x, y: center.y, width: 2 * radius, height: 2 * radius)
        context.addEllipse(in: rectangle)
        context.strokePath()
        
        context.setFillColor(fillColor.cgColor)
        context.fillEllipse(in: rectangle)
    }
}
