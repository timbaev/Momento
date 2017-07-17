//
//  FolderCollectionViewController.swift
//  Momento
//
//  Created by Elina on 14/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "folderCell"

class FolderCollectionViewController: UICollectionViewController {
    
    var folderArray : [FolderData] = []

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
        let folderCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FolderCollectionViewCell
        
        let folder = folderArray[indexPath.item]
       
        if folder.cellsArray.count != 0, folder.cellsArray.last != nil{
            folderCell.folderImage.image = folder.cellsArray.last?.cellImage
        }
        else {
            folderCell.folderImage.image = UIImage(named: "emptyFolder")
        }
        folderCell.folderLabel.text = folderArray[indexPath.item].name
        
        return folderCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "folder", sender: indexPath.item)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "folder" && sender != nil {
            let index = sender as! Int
            
        
            let destinationVC = segue.destination as! CollectionViewController
            destinationVC.indexOfFolder = sender as! Int
            
            destinationVC.cellDataArray = folderArray[index].cellsArray
        }
    }
}
