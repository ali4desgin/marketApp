//
//  SubcategoryCell.swift
//  Store
//
//  Created by MAC on 8/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class SubcategoryCell: UICollectionViewCell {
    
    
    var delg : SubCategoryViewController!
    var levels = [LevelsModel]()
    
    var levelscollection : UICollectionView!
    let levelcellid = "levelcellid"
    let subcategoryTitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "Technology"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        
        return lbl
    }()
    
    let subcategoryViewAllButton : UIButton = {
        let lbl = UIButton()
        lbl.setTitle("View All", for: [])
        lbl.setTitleColor(UIColor.black, for: [])
        //        lbl.setAttributedTitle(NSAttributedString, for: [])
        lbl.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        //        lbl.textColor = .black
        
        lbl.isHidden  = true
        return lbl
    }()
    
    
    let seprator : UIView = {
        let lbl = UIView()
        lbl.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViews()
        setupViews()
        
    }
    
    
    func setupCollectionViews( )  {
        let layout =  UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        levelscollection = UICollectionView(frame: frame, collectionViewLayout: layout )
        levelscollection.alwaysBounceHorizontal = true
        
        levelscollection?.delegate = self
        levelscollection?.dataSource = self
        levelscollection?.backgroundColor =  UIColor.clear
        levelscollection?.register(SubcatehoryLevelCell.self, forCellWithReuseIdentifier: levelcellid)
        levelscollection?.alwaysBounceVertical = false
        
    }
    
    
    func setupViews() {
        
        
        
        
        addSubview(levelscollection)
        addSubview(subcategoryViewAllButton)
        addSubview(subcategoryTitle)
        addSubview(seprator)
        
        // const
        
        
        subcategoryTitle.anchor(topAnchor, left: leftAnchor, bottom: levelscollection.topAnchor, right: subcategoryViewAllButton.leftAnchor, topConstant: 8, leftConstant: 12, bottomConstant: 0, rightConstant:12, widthConstant: 0, heightConstant: 0)
        
        subcategoryViewAllButton.anchor(topAnchor, left: subcategoryTitle.rightAnchor, bottom: levelscollection.topAnchor, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        levelscollection.anchor(subcategoryTitle.bottomAnchor, left: leftAnchor, bottom: seprator.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        seprator.anchor(levelscollection.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

