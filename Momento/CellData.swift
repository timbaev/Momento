//
//  CellData.swift
//  Momento
//
//  Created by Elina on 17/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

struct CellData {
    var cellDescription: String
    var cellText: String
    var cellImage: UIImage
    
}

extension CellData {
    init?(data: NSData) {
        let coding = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! Encoding
        cellDescription = coding.cellDescription as String
        cellText = coding.cellText as String
        cellImage = coding.cellImage as! UIImage
    }
    
    func encode() -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: Encoding(self)) as NSData
    }
    
    private class Encoding: NSObject, NSCoding {
        let cellDescription: NSString
        let cellText: NSString
        let cellImage: NSObject
        
        init(_ cellData: CellData) {
            cellDescription = cellData.cellDescription as NSString
            cellText = cellData.cellText as NSString
            cellImage = cellData.cellImage
        }
        
        @objc required init?(coder aDecoder: NSCoder) {
            let cellDescription = aDecoder.decodeObject(forKey: "cellDescription") as! NSString
            self.cellDescription = cellDescription
            cellText = aDecoder.decodeObject(forKey: "cellText") as! NSString
            cellImage = aDecoder.decodeObject(forKey: "cellImage") as! NSObject
        }
        
        @objc func encode(with aCoder: NSCoder) {
            aCoder.encode(cellDescription, forKey: "cellDescription")
            aCoder.encode(cellText, forKey: "cellText")
            aCoder.encode(cellImage, forKey: "cellImage")
        }
    }
}
