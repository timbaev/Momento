//
//  CollectionViewController.swift
//  Momento
//
//  Created by Elina on 13/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

struct CellData {
    var cellText: String
    var cellImage: UIImage
    
    init(text: String, image: UIImage) {
        cellText = text
        cellImage = image
    }
}
private let reuseIdentifier = "Cell"

class CollectionViewController:  UICollectionViewController{
    
    var cellDataArray:[CellData] = [] 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        performSegue(withIdentifier: "detail", sender: indexPath.item)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" && sender != nil {
            let index = sender as! Int
            
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.text = cellDataArray[index].cellText
            destinationVC.image = cellDataArray[index].cellImage
        }
    }
    
    
}
