//
//  DatabaseModel.swift
//  Momento
//
//  Created by Elina on 17/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

final class DatabaseModel {
    
    var data = [FolderData]()
    private let folderNames = ["Пейзажи", "Семья", "Документы", "Эскизы", "Автографы", "Прочее"]
    
    static let instance = DatabaseModel()
    
    private init() {
        if UserDefaults.standard.object(forKey: "firstInit") == nil {
            for folderName in folderNames {
                data.append(FolderData(text: folderName, array: []))
                saveData(array: [CellData](), folderName: folderName)
            }
            UserDefaults.standard.set(false, forKey: "firstInit")
        } else {
            for folderName in folderNames {
                data.append(FolderData(text: folderName, array: getData(folderName: folderName)))
            }
        }
    }
    
    func saveData(array: [CellData], folderName: String) {
        let encoded = array.map { $0.encode() }
        UserDefaults.standard.set(encoded, forKey: folderName)
    }
    
    func getData(folderName: String) -> [CellData] {
        let dataArray = UserDefaults.standard.object(forKey: folderName) as! [NSData]
        let savedCellData = dataArray.map { CellData(data: $0)! }
        return savedCellData
    }
}
