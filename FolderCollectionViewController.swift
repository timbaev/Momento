//
//  FolderCollectionViewController.swift
//  Momento
//
//  Created by Elina on 14/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "folderCell"

struct FolderData {
    var cellsArray: [CellData]
    var name: String
    
    init(text: String, array: [CellData]) {
        name = text
        cellsArray = array
    }
}

class FolderCollectionViewController: UICollectionViewController {
    
    var folderArray : [FolderData] = [FolderData(text: "Folder", array: [CellData(text: "Name1",image: UIImage(named: "1")!),CellData(text: "Name2",image: UIImage(named: "2")!)])]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            destinationVC.cellDataArray = folderArray[index].cellsArray
        }
    }}
