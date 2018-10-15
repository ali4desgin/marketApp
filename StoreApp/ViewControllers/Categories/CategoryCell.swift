//
//  CategoryCell.swift
//  Store
//
//  Created by MAC on 8/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class CategoryCell: UITableViewCell {
    
    
    let categoryImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "technology")
        image.layer.cornerRadius = 23
        image.layer.masksToBounds = true
        return image
    }()
    
    let categoryTitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "Technology"
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .gray
        return lbl
    }()
    
    let categoryNumberOFSubCategories : UILabel = {
        let lbl = UILabel()
        lbl.text = "493"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = .white
        lbl.layer.cornerRadius = 5
        lbl.layer.masksToBounds = true
        lbl.backgroundColor = main_color
        return lbl
    }()
    
    let categoryDescription : UILabel = {
        let lbl = UILabel()
        lbl.text = "Phone | TV | Socail Media Servers | Online Products "
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = .gray
        return lbl
    }()
    
    let seprator : UIView = {
        let lbl = UIView()
        lbl.backgroundColor = .gray
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setupViews()  {
        addSubview(categoryImage)
        addSubview(categoryTitle)
        addSubview(categoryDescription)
        addSubview(categoryNumberOFSubCategories)
        addSubview(seprator)
        
        categoryImage.anchor(topAnchor, left: leftAnchor, bottom:bottomAnchor, right: nil, topConstant: 15, leftConstant: 12, bottomConstant: 15, rightConstant: 8, widthConstant: 60, heightConstant: 60)
        categoryTitle.anchor(categoryImage.topAnchor, left: categoryImage.rightAnchor, bottom: categoryDescription.topAnchor, right: categoryNumberOFSubCategories.leftAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        categoryDescription.anchor(categoryTitle.bottomAnchor, left: categoryImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        
        categoryNumberOFSubCategories.anchor(categoryImage.topAnchor, left: categoryTitle.rightAnchor, bottom: categoryDescription.topAnchor, right: rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 50, heightConstant: 20   )
        
        
    }
    
    
    
}

