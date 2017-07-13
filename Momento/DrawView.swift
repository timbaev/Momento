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
    var lastPoint: CGPoint!
    var drawColor: UIColor = UIColor.black
    var lineWidth: Int = 5

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = touches.first?.location(in: self)
        lines.append(Line(start: lastPoint, end: newPoint!, color: drawColor, width: lineWidth))
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        for line in lines {
            context?.beginPath()
            context?.setLineWidth(line.width)
            context?.move(to: CGPoint(x: line.startX, y: line.startY))
            context?.addLine(to: CGPoint(x: line.endX, y: line.endY))
            context?.setStrokeColor(line.color.cgColor)
            context?.strokePath()
        }
    }
}
