//
//  SideMenCell.swift
//  StoreApp
//
//  Created by MAC on 8/31/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class SideMenCell: UITableViewCell {
    
    
  
    let textLable: UILabel = {
        let label  = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let countTxt: UILabel = {
        let label  = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let imageVie: UIImageView = {
       let imageV = UIImageView()
        imageV.image = #imageLiteral(resourceName: "user1")
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
        setupViews()
    }
    
    func setupViews()  {
        addSubview(imageVie)
        addSubview(textLable)
        addSubview(countTxt)
        imageVie.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 10, rightConstant: 5, widthConstant: 30, heightConstant: 30)
        textLable.anchor(topAnchor, left: imageVie.rightAnchor, bottom: bottomAnchor, right: countTxt.leftAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        countTxt.anchor(topAnchor, left: textLable.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
