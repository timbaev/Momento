//
//  Line.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 12.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class Line: Figure {
    var start: CGPoint
    var end: CGPoint
    var color: UIColor
    var lineWidth: CGFloat
    var opacity: CGFloat
    
    var startX: CGFloat {
        get {
            return start.x
        }
    }
    
    var startY: CGFloat {
        get {
            return start.y
        }
    }
    
    var endX: CGFloat {
        get {
            return end.x
        }
    }
    
    var endY: CGFloat {
        get {
            return end.y
        }
    }
    
    init(start _start: CGPoint, end _end: CGPoint, color _color: UIColor, lineWidth _width: Int, opacity _alpha: CGFloat) {
        start = _start
        end = _end
        color = _color
        lineWidth = CGFloat(_width)
        opacity = _alpha
    }
    
    func draw(with context: CGContext) {
        context.beginPath()
        context.setLineWidth(lineWidth)
        context.move(to: CGPoint(x: startX, y: startY))
        context.addLine(to: CGPoint(x: endX, y: endY))
        context.setStrokeColor(color.cgColor)
        context.setAlpha(opacity)
        context.strokePath()
    }
}
