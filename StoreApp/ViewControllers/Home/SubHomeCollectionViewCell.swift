//
//  SubHomeCollectionViewCell.swift
//  StoreApp
//
//  Created by MAC on 9/14/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit

class SubHomeCollectionViewCell: UICollectionViewCell {
    
    
    let ads_image : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "naser_vip2")
        image.layer.cornerRadius = 30
        image.layer.borderColor = main_color.cgColor
        image.layer.borderWidth = 0
        image.layer.masksToBounds = true    
        return image
    }()
    
    let ads_price : UILabel = {
        let text = UILabel()
        text.text = "30 USD"
        text.font = UIFont.boldSystemFont(ofSize: 12)
        text.textColor = darkGreenColor
        return text
    }()
    
    
    let ads_description : UILabel = {
        let text = UILabel()
        text.text = "some think as text for test just , check this and check it as text folder"
//        text.isEditable = false ;
//        text.isSelectable = false
//        text.isScrollEnabled = false

        text.font = UIFont.systemFont(ofSize: 13)
        text.numberOfLines = 0
        text.textColor = so_light_gray4
        return text
    }()
    
    
    let ads_title : UILabel = {
        let text = UILabel()
        text.text = "some think as text for test just , check this and check it as text folder"
        //        text.isEditable = false ;
        //        text.isSelectable = false
        //        text.isScrollEnabled = false
        
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.numberOfLines = 0
        text.textColor = .black
        return text
    }()
    let user_image : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "naser_gold")
        image.layer.borderColor = white_color.cgColor
        image.layer.borderWidth = 2
        image.layer.cornerRadius = 13
        image.layer.masksToBounds = true
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
     //   backgroundColor = so_light_gray
        layer.borderColor = main_color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addSubview(ads_image)
        addSubview(user_image)
        addSubview(ads_price)
        addSubview(ads_title)
        
        addSubview(ads_description)
        ads_image.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        user_image.anchor(nil, left: nil, bottom: ads_image.bottomAnchor, right: ads_image.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 26, heightConstant: 26)
        
        ads_price.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    
        
        ads_title.anchor(ads_price.bottomAnchor, left: ads_image.rightAnchor, bottom: ads_description.topAnchor, right: rightAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 5, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        ads_description.anchor(ads_image.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 5, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
