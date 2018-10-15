//
//  HomeTableViewCell.swift
//  StoreApp
//
//  Created by MAC on 9/13/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire

class HomeTableViewCell: UITableViewCell {
    
   // let cellid2 = "cellid2"
    let ads_image : UIImageView = {
       let image = UIImageView()
        image.image = #imageLiteral(resourceName: "naser_vip")
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        return image
    }()
    
    
    let ads_title : UILabel = {
        let text = UILabel()
        text.text = "Ali"
        return text
    }()
    
    
    
    //var items = [HomeAds]()
    
   
    
    let ads_description : UITextView = {
        let text = UITextView()
        text.text = "some think as text for test just , check this and check it as text folder"
        text.isEditable = false ;
        text.isSelectable = false
        text.isScrollEnabled = false 
        text.textColor = so_light_gray4
        return text
    }()
    
    
    
    let ads_price : UILabel = {
        let text = UILabel()
        text.text = "30 USD"
        text.font = UIFont.boldSystemFont(ofSize: 14)
        text.textColor = darkGreenColor
        return text
    }()
    
    

    
    
    
//    let view_all : UIButton = {
//        let text = UIButton(type: .system);
//        text.setTitle("View All", for: .normal)
//        text.setTitleColor(UIColor.gray, for: .normal)
//        return text
//    }()
//
//    let pined_ads : UILabel = {
//        let text = UILabel()
//        text.text = "Pined Ads"
//        text.font = UIFont.boldSystemFont(ofSize: 14)
//        text.textColor =  .gray
//        return text
//    }()
//

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }


    
    func setupViews( )  {

        addSubview(ads_image)
        addSubview(ads_title)
        addSubview(ads_description)

        addSubview(ads_price)
        
        
        ads_image.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        ads_title.anchor(topAnchor, left: ads_image.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 18, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        
        ads_price.anchor(topAnchor, left: nil, bottom: ads_description.topAnchor, right: rightAnchor, topConstant: 18, leftConstant: 4, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        
        
        ads_description.anchor(ads_title.bottomAnchor, left: ads_image.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: -2, leftConstant: 4, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        
        
        
        
    }

}




