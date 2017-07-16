//
//  DrawView.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 12.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines: [Line] = []
    var rectangles: [Rectangle] = []
    var circles: [Circle] = []
    var lastPoint: CGPoint!
    var drawColor: UIColor = UIColor.black
    var lineWidth: Int = 5
    var opacity: CGFloat = 1
    var shape: Int = 0
    var tempRectangle: Rectangle!
    var tempCircle: Circle!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = (touches.first?.location(in: self))!
        
        if (shape == 0) {
            lines.append(Line(start: lastPoint, end: newPoint, color: drawColor, width: lineWidth, alpha: opacity))
        }
        
        if (shape == 1) {
            if (tempRectangle == nil) {
                tempRectangle = Rectangle(center: lastPoint, width: 2 * (newPoint.x - lastPoint.x), height: 2 * (newPoint.y - lastPoint.y), lineWidth: lineWidth, strokeColor: UIColor.black, fillColor: UIColor.blue)
            } else {
                tempRectangle.width = 2 * (newPoint.x - tempRectangle.center.x)
                tempRectangle.height = 2 * (newPoint.y - tempRectangle.center.y)
                tempRectangle.strokeColor = drawColor
            }
        }
        
        if (shape == 2) {
            if (tempCircle == nil) {
                tempCircle = Circle(center: lastPoint, lineWidth: lineWidth, radius: circleRadius(for: lastPoint, newPoint), color: drawColor)
            } else {
                tempCircle.radius = circleRadius(for: tempCircle.center, newPoint)
                tempCircle.color = drawColor
            }
        }
        
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (shape == 1 && tempRectangle != nil) {
            rectangles.append(tempRectangle)
            tempRectangle = nil
        }
        if (shape == 2 && tempCircle != nil) {
            circles.append(tempCircle)
            tempCircle = nil
        }
    }
    
    private func draw(circles: [Circle]) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        for circle in circles {
            context.beginPath()
            context.setLineWidth(CGFloat(circle.lineWidth))
            context.setStrokeColor(circle.color.cgColor)
            context.addArc(center: circle.center, radius: circle.radius, startAngle: 0, endAngle: circle.endAngle, clockwise: true)
            context.strokePath()
        }
    }
    
    private func draw(rectangles: [Rectangle]) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        for rectangle in rectangles {
            context.beginPath()
            context.addRect(CGRect(x: rectangle.center.x, y: rectangle.center.y, width: rectangle.width, height: rectangle.height))
            context.setLineWidth(CGFloat(rectangle.lineWidth))
            context.setStrokeColor(rectangle.strokeColor.cgColor)
            context.strokePath()
        
            context.setFillColor(rectangle.fillColor.cgColor)
            context.fillPath()
            context.strokePath()
        }
    }
    
    private func draw(lines: [Line]) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        for line in lines {
            context?.beginPath()
            context?.setLineWidth(line.width)
            context?.move(to: CGPoint(x: line.startX, y: line.startY))
            context?.addLine(to: CGPoint(x: line.endX, y: line.endY))
            context?.setStrokeColor(line.color.cgColor)
            context?.setAlpha(line.alpha)
            context?.strokePath()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if (tempRectangle != nil) {
            draw(rectangles: [tempRectangle])
        }
        if (tempCircle != nil) {
            draw(circles: [tempCircle])
        }
        draw(rectangles: rectangles)
        draw(lines: lines)
        draw(circles: circles)
    }
}

extension DrawView {
    func circleRadius(for point1: CGPoint,_ point2: CGPoint) -> CGFloat {
        return sqrt((point2.x - point1.x) * (point2.x - point1.x) + (point2.y - point1.y) * (point2.y - point1.y))
    }
}
