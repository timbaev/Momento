//
//  Triangle.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 16.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import Foundation

class Triangle: Figure {
    var A, B, C: CGPoint
    var color: UIColor
    var fillColor: UIColor
    var lineWidth: CGFloat
    var opacity: CGFloat
    
    init(A: CGPoint, B: CGPoint, C: CGPoint, color: UIColor, fillColor: UIColor, lineWidth: CGFloat, opacity: CGFloat) {
        self.A = A
        self.B = B
        self.C = C
        self.color = color
        self.lineWidth = lineWidth
        self.fillColor = fillColor
        self.opacity = opacity
    }
    
    func draw(with context: CGContext) {    
        let line = UIBezierPath()
        
        line.lineWidth = lineWidth
        line.move(to: A)
        line.addLine(to: B)
        line.addLine(to: C)
        line.addLine(to: A)
        line.close()
        color.setStroke()
        fillColor.setFill()
        
        line.stroke()
        line.fill()
    }
}
