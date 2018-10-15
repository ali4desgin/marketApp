//
//  LevelCell.swift
//  Store
//
//  Created by MAC on 8/5/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class LevelCell: UICollectionViewCell {
    
    let adsImage : UIImageView = {
        let image = UIImageView()
      //  image.image = #imageLiteral(resourceName: "item1")
        image.contentMode = .scaleToFill
        return image
    }()
    
    let pinAds:UIImageView = {
       let image = UIImageView()
        image.image = #imageLiteral(resourceName: "pin_icon").withRenderingMode(.alwaysTemplate)
        image.tintColor = main_color
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    let adsPrice : UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.textColor = .white
        //  image.image = #imageLiteral(resourceName: "item1")
       // image.contentMode = .scaleToFill
        return text
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews()  {
        
        layer.borderWidth = 0.20
        layer.borderColor = white_color.cgColor
        addSubview(adsImage)
        addSubview(adsPrice)
        addSubview(pinAds)
        adsImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        adsPrice.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0   )
        
        
        pinAds.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20   )
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

