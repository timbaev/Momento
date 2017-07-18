//
//  PickerCollectionViewController.swift
//  Momento
//
//  Created by Elina on 18/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PickerCell"

class PickerCollectionViewController: UICollectionViewController {
    
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
    //!!!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        DatabaseModel.instance.data[indexPath.item].cellsArray.append(CellData(cellDescription: descriptionText, cellText: text, cellImage: image))

        let rootVC = self.navigationController?.viewControllers.first as! ViewController
        rootVC.imageSavedMessage()
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
   

}
