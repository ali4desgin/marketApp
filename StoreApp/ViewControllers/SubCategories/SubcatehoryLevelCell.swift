//
//  LevelCell.swift
//  Store
//
//  Created by MAC on 8/2/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class SubcatehoryLevelCell: UICollectionViewCell {
    
    
    let LevelImage : UIImageView = {
        let image = UIImageView()
       // image.image = #imageLiteral(resourceName: "user")
        image.layer.cornerRadius = 18
        image.layer.masksToBounds = true
        return image
    }()
    
    let LevelTitle : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Technology"
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = .gray
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    
    
    func setupViews()  {
        
        addSubview(LevelImage)
        addSubview(LevelTitle)
        LevelImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 60, heightConstant: 60)
        LevelTitle.anchor(LevelImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

