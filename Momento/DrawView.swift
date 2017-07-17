//
//  DrawView.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 12.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var figures: [Figure] = []
    var lastPoint: CGPoint!
    var drawColor: UIColor = UIColor.black
    var fillColor: UIColor = UIColor.clear
    var lineWidth: Int = 5
    var opacity: CGFloat = 1
    var shape: Int = 0
    var tempFigure: Figure!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = (touches.first?.location(in: self))!
        
        if (shape == 0) {
            figures.append(Line(start: lastPoint, end: newPoint, color: drawColor, lineWidth: lineWidth, opacity: opacity))
        }
        
        if (shape == 1) {
            if (tempFigure == nil) {
                tempFigure = Rectangle(center: lastPoint, width: 2 * (newPoint.x - lastPoint.x), height: 2 * (newPoint.y - lastPoint.y), lineWidth: CGFloat(lineWidth), color: drawColor, fillColor: fillColor, opacity: opacity)
            } else {
                let tempRectangle = tempFigure as! Rectangle
                tempRectangle.width = 2 * (newPoint.x - tempRectangle.center.x)
                tempRectangle.height = 2 * (newPoint.y - tempRectangle.center.y)
            }
        }
        
        if (shape == 2) {
            if (tempFigure == nil) {
                tempFigure = Circle(center: lastPoint, lineWidth: CGFloat(lineWidth), radius: circleRadius(for: lastPoint, newPoint), color: drawColor, fillColor: fillColor, opacity: opacity)
            } else {
                let tempCircle = tempFigure as! Circle
                tempCircle.radius = circleRadius(for: tempCircle.center, newPoint)
            }
        }
        
        if (shape == 3) {
            if (tempFigure == nil) {
                tempFigure = Triangle(A: lastPoint, B: newPoint, C: thirdTrianglePoint(for: lastPoint, newPoint), color: drawColor, fillColor: fillColor, lineWidth: CGFloat(lineWidth), opacity: opacity)
            } else {
                let tempTriangle = tempFigure as! Triangle
                tempTriangle.B = newPoint
                tempTriangle.C = thirdTrianglePoint(for: tempTriangle.A, newPoint)
            }
        }
        
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (shape != 0 && tempFigure != nil) {
            figures.append(tempFigure)
            tempFigure = nil
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        if (tempFigure != nil) {
            tempFigure.draw(with: context)
        }
        for figure in figures {
            figure.draw(with: context)
        }
    }
}

extension DrawView {
    func circleRadius(for point1: CGPoint,_ point2: CGPoint) -> CGFloat {
        return sqrt((point2.x - point1.x) * (point2.x - point1.x) + (point2.y - point1.y) * (point2.y - point1.y))
    }
    func thirdTrianglePoint(for point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point2.x - 2 * (point2.x - point1.x)), y: point2.y)
    }
}
