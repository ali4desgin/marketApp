//
//  ItemCommentsCell.swift
//  Store
//
//  Created by MAC on 8/3/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class ItemCommentsCell: UICollectionViewCell {
    
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Some Advertise"
        label.textAlignment = .left
        label.textColor = main_color
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let userProfileImages: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "user")
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 20
        img.layer.masksToBounds = true
        return img
    }()
    
    
    
    
    let CommentDate: UILabel = {
        let label = UILabel()
        label.text = "03:09 pm"
        label.textColor = UIColor(white: 0.80, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    let CommentConetent: UILabel = {
        let label = UILabel()
        label.text = "Because you have to instantiate your viewController before push. First of all you have to be sure if you have a navigationController, then to instatiate your "
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    
    func setupViews()  {
        
        
        
        addSubview(userProfileImages)
        addSubview(userName)
        addSubview(CommentDate)
        addSubview(CommentConetent)
        
        userProfileImages.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        userName.anchor(topAnchor, left: userProfileImages.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 18, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        CommentDate.anchor(userName.bottomAnchor, left: userProfileImages.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 3, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        CommentConetent.anchor(userProfileImages.bottomAnchor, left: userProfileImages.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 12, bottomConstant: 5, rightConstant: 12, widthConstant: 0, heightConstant: 0)
    }
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

