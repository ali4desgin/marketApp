//
//  UserProfileHeader.swift
//  Store
//
//  Created by MAC on 8/3/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class UserProfileHeader: UICollectionViewCell {
    
    var delg : UserProfileViewController!
    let coverImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "cover1")
        img.contentMode = .scaleToFill
        return img
    }()
    
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "user")
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 5
        img.layer.cornerRadius = 45
        img.layer.masksToBounds = true
        return img
    }()
    
    
    let username: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = "@Ali Abdalla"
        lbl.textColor = .white
        return lbl
    }()
    
    let country: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        lbl.text = "Sudan - Khartoum"
        lbl.textColor = .gray
        return lbl
    }()
    
    
    
    let followImage : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "favorite").withRenderingMode(.alwaysTemplate), for: [])
        btn.tintColor = main_color
        return btn
    }()
    
    let messageImage : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "chat").withRenderingMode(.alwaysTemplate), for: [])
        btn.tintColor = main_color
        return btn
    }()
    
    let callImage : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "call").withRenderingMode(.alwaysTemplate), for: [])
        btn.tintColor = main_color
        return btn
    }()
    
    
    let bio : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.text = "Something About Bio Going here Something About Bio Going here Something About Bio Going here Something About Bio Going here Something About Bio Going here"
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    
    let editmyprofile : UIButton = {
       let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = main_color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews()  {
        addSubview(coverImage)
        addSubview(profileImage)
        addSubview(username)
        
        
        addSubview(followImage)
        addSubview(callImage)
        addSubview(messageImage)
        
        addSubview(editmyprofile)
        
        addSubview(bio)
        addSubview(country)
        coverImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 140)
        profileImage.anchor(nil, left: leftAnchor, bottom: coverImage.bottomAnchor, right: nil, topConstant: 0, leftConstant: 12, bottomConstant: -45, rightConstant: 0, widthConstant: 90, heightConstant: 90)
        username.anchor(profileImage.topAnchor, left: profileImage.rightAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        messageImage.anchor(coverImage.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 20, heightConstant: 20)
        
        
        editmyprofile.anchor(coverImage.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 25)
        
        callImage.anchor(coverImage.bottomAnchor, left: nil, bottom: nil, right: messageImage.leftAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 20, heightConstant: 20)
        
        followImage.anchor(coverImage.bottomAnchor, left: nil, bottom: nil, right: callImage.leftAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 20, heightConstant: 20)
        
        country.anchor(coverImage.bottomAnchor, left: profileImage.rightAnchor, bottom: nil, right: followImage.leftAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        bio.anchor(profileImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 12, bottomConstant: 8, rightConstant: 12, widthConstant: 0, heightConstant: 0   )
        
        
        editmyprofile.addTarget(self, action: #selector(editmyprofileTrans), for: .touchDown)
        
    }
    
    
    @objc func editmyprofileTrans() {
        let activity = EditProfileViewController()
       // activity.navigationItem.prefersLargeTitles = false
        self.delg?.navigationController?.pushViewController(activity, animated: true)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

