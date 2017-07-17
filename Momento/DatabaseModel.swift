//
//  DatabaseModel.swift
//  Momento
//
//  Created by Elina on 17/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

final class DatabaseModel {
    
    var data: [FolderData]!
    
    static let instance = DatabaseModel()
    
    private init() {
        data = [FolderData(text: "Folder", array: [CellData(cellDescription: "Google",cellText: "Name1",cellImage: UIImage(named: "1")!),CellData(cellDescription: "Tabigat",cellText: "Name2",cellImage: UIImage(named: "2")!)])]
    }
}
