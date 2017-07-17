//
//  FolderData.swift
//  Momento
//
//  Created by Elina on 17/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import Foundation
struct FolderData {
    var cellsArray: [CellData]
    var name: String
    
    init(text: String, array: [CellData]) {
        name = text
        cellsArray = array
    }
}
