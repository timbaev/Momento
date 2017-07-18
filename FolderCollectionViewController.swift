//
//  FolderCollectionViewController.swift
//  Momento
//
//  Created by Elina on 14/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

private let reuseIdentifier = "folderCell"

class FolderCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var folderArray : [FolderData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        folderArray = DatabaseModel.instance.data
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: true)
        
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}



