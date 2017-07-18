//
//  CollectionViewCell.swift
//  Momento
//
//  Created by Elina on 13/07/2017.
//  Copyright © 2017 ITIS iOS Lab. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var cellLabel: UILabel!
    
    var checkboxImageView: UIImageView?
    var editing: Bool = false{
        didSet{
            self.checkboxImageView!.isHidden = !editing
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if editing{
                self.checkboxImageView!.image = UIImage(named: isSelected ? "checked" : "unchecked")
                
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSubviews()
        self.autolayoutSubviews()
    }
    
    
    
    func setupSubviews(){
        self.checkboxImageView = UIImageView()
        self.checkboxImageView!.translatesAutoresizingMaskIntoConstraints = false
        self.checkboxImageView!.contentMode = .scaleAspectFit
        self.checkboxImageView!.clipsToBounds = true
        self.checkboxImageView!.isHidden = true
        self.checkboxImageView!.image = UIImage(named : "unchecked")
        self.contentView.addSubview(self.checkboxImageView!)
        
    }
    
    func autolayoutSubviews(){
        self.checkboxImageView!.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.checkboxImageView!.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.checkboxImageView!.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.checkboxImageView!.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        
    }
    
}
