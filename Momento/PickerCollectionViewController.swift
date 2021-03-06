//
//  PickerCollectionViewController.swift
//  Momento
//
//  Created by Elina on 18/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PickerCell"

class PickerCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var image: UIImage!

    var folderArray : [FolderData] = []
    
    var text: String = ""
    var descriptionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        folderArray = DatabaseModel.instance.data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return folderArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let folderCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PickerCollectionViewCell
        
        let folder = folderArray[indexPath.item]
        
        if folder.cellsArray.count != 0, folder.cellsArray.last != nil{
            folderCell.folderImageSave.image = folder.cellsArray.last?.cellImage
        }
        else {
            folderCell.folderImageSave.image = UIImage(named: "emptyFolder")
        }
        folderCell.folderLabelSave.text = folderArray[indexPath.item].name
        
        return folderCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        DatabaseModel.instance.data[indexPath.item].cellsArray.append(CellData(cellDescription: descriptionText, cellText: text, cellImage: image))
        
        let folder = DatabaseModel.instance.data[indexPath.item]
        print("Test indexPath \(indexPath.item)")
        //DatabaseModel.instance.convertAndSaveInDDPath(array: folder.cellsArray, folderName: folder.name)
        DatabaseModel.instance.saveData(array: folder.cellsArray, folderName: folder.name)
        
        let rootVC = self.navigationController?.viewControllers.first as! ViewController
        rootVC.imageSavedMessage()
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 184, height: 184)
        
        switch UIDevice.current.type {
        case .simulator:
            return CGSize(width: 156, height: 156)
        case .iPhone5:
            return CGSize(width: 156, height: 156)
        case .iPhone5S:
            return CGSize(width: 156, height: 156)
        case .iPhone6:
            return size
        case .iPhoneSE:
            return CGSize(width: 156, height: 156)
        case .iPhone6plus:
            return size
        case .iPhone7:
            return size
        case .iPhone7plus:
            return size
        default:
            return size
        }
        
        
    }


}
