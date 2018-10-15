//
//  RoomCell.swift
//  StoreApp
//
//  Created by MAC on 9/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit

class ChatRoomCell: UITableViewCell {

    
    let bg = UIView()
    

    let with: UILabel = {
        let label = UILabel()
        label.text = "Ali Abdalla"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let lastmessage: UILabel = {
        let label = UILabel()
        label.text = "Hello i love the kinf of programming! , i would like to become ios profiessonal developer"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let withImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "user")
        image.layer.cornerRadius = 30
        image.layer.masksToBounds  = true
        
        return image
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        bg.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bg.tintColor = white_color
        
        selectedBackgroundView = bg
    }
    
    
    
    
    fileprivate func setupViews(){
        addSubview(withImage)
        addSubview(with)
        addSubview(lastmessage)
        withImage.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 10, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        with.anchor(topAnchor, left: withImage.rightAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        lastmessage.anchor(with.bottomAnchor, left: with.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    

}
