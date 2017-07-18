//
//  CollectionViewController.swift
//  Momento
//
//  Created by Elina on 13/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController:  UICollectionViewController{

    @IBOutlet var moveToTrash: UIBarButtonItem!
    @IBOutlet var photoCollection: UICollectionView!
    
    var cellDataArray:[CellData] = []
    
    var indexOfFolder: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem  //куда поставить эту кнопку
        self.navigationController?.isToolbarHidden = false
        //Delete from bottom bar
        hideBottomButton(hide: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cellDataArray = DatabaseModel.instance.data[indexOfFolder].cellsArray
        photoCollection.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.collectionView!.allowsMultipleSelection = editing
        let indexPaths: [NSIndexPath] = self.collectionView!.indexPathsForVisibleItems as [NSIndexPath]
        
        for indexPath in indexPaths{
            self.collectionView!.deselectItem(at: indexPath as IndexPath, animated: false)
            let cell: CollectionViewCell? = self.collectionView!.cellForItem(at: indexPath as IndexPath) as? CollectionViewCell
            cell?.editing = editing
            
            if editing{
                hideBottomButton(hide: false)
            }
            else{
                hideBottomButton(hide: true)
            }
        }
    }
    
    private func hideBottomButton(hide: Bool) {
        if (hide) {
            var toolbarButtons: [UIBarButtonItem] = toolbarItems!
            toolbarButtons.remove(at: 1)
            setToolbarItems(toolbarButtons, animated: true)
        } else {
            var toolbarButtons = toolbarItems
            toolbarButtons?.append(moveToTrash)
            setToolbarItems(toolbarButtons, animated: true)
            moveToTrash.action = #selector(self.deleteSelectedItemsAction(sender:))
        }
    }
    
    func deleteSelectedItemsAction(sender: UIBarButtonItem){
        let selectedIndexPaths: [NSIndexPath] = self.collectionView!.indexPathsForSelectedItems as [NSIndexPath]!
        
        var newCellDataArray: [CellData] = []
        
        for i in (0..<cellDataArray.count){
            var found: Bool = false
            for indexPath in selectedIndexPaths{
                if indexPath.row == i{
                    found = true
                    break
                }
            }
            if found == false{
                newCellDataArray.append(self.cellDataArray[i])
            }
        }
        
        self.cellDataArray = newCellDataArray
        DatabaseModel.instance.data[indexOfFolder].cellsArray = newCellDataArray
        self.collectionView!.deleteItems(at: selectedIndexPaths as [IndexPath])
        hideBottomButton(hide: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cellDataArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = cellDataArray[indexPath.item].cellImage
        
        cell.cellLabel.text = cellDataArray[indexPath.item].cellText
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isEditing == false{
        performSegue(withIdentifier: "detail", sender: indexPath.item)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" && sender != nil {
            let index = sender as! Int
            
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.folderIndex = indexOfFolder
            //передаем индекс папки
            destinationVC.indexInFolder = sender as! Int //передаем индекс в папке
            
            destinationVC.descriptionText = cellDataArray[index].cellDescription
            destinationVC.text = cellDataArray[index].cellText
            destinationVC.image = cellDataArray[index].cellImage
        }
    }
    
    
}


