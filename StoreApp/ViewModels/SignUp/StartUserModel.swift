//
//  LoginModel.swift
//  StoreApp
//
//  Created by MAC on 8/27/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct StartUserModel: Decodable {
    var status: Int!
    var message: String!
    var old_register: String!
    var id: String!
    var user: UserLoginDeatils!
    
    
}

struct UserLoginDeatils: Decodable {
    var id: String!
    var phone: String!
    var username: String!
    var email: String!
    var gender: String!
    var profile_image: String!
    var cover_image: String!
    var bio: String!
    var country: String!
    var current_location: String!
    var status: String!
    var instgaram_account: String!
    var linkin_account: String!
    var twitter_account: String!
    var login_at: String!
    var balance: String!
    var token:String!
    var profile_status:String!

}

/*
 "phone": "0989221634",
 "username": "khalidwwesdswsdsd",
 "email": "kalid@gmail.comseassdedad",
 "gender": "1",
 "profile_image": "http://localhost/aptanaSudio/Libraries/data/default/profile.jpg",
 "cover_image": "http://localhost/aptanaSudio/Libraries/data/default/cover.jpg",
 "bio": null,
 "country": null,
 "current_location": null,
 "status": "1",
 "instgaram_account": null,
 "linkin_account": null,
 "twitter_account": null,
 "login_at": "2018-08-20 23:31:35",
 "balance": "0"
 */
