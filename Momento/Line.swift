//
//  Line.swift
//  Momento
//
//  Created by Тимур Шафигуллин on 12.07.17.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class Line {
    var start: CGPoint
    var end: CGPoint
    var color: UIColor
    var width: CGFloat
    var alpha: CGFloat
    
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
    
    init(start _start: CGPoint, end _end: CGPoint, color _color: UIColor, width _width: Int, alpha _alpha: CGFloat) {
        start = _start
        end = _end
        color = _color
        width = CGFloat(_width)
        alpha = _alpha
    }
}
