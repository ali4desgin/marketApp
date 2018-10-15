//
//  CustomerModel.swift
//  StoreApp
//
//  Created by MAC on 8/29/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit


struct ProfileModel:Decodable  {
    var status:Int!
    var message:String!
    var customer:CustomerModel!
    var ads:[AdsCellModel]!
}

struct  CustomerModel:Decodable {
    
    /*
     "id": "1",
     "phone": "0113014165",
     "username": "aliabdalla",
     "password": "123456",
     "email": "dev.master.co@gmail.com",
     "gender": "0",
     "facebook_account": null,
     "instgaram_account": null,
     "linkin_account": null,
     "twitter_account": null,
     "profile_image": "https://www.colocationamerica.com/images/100.jpeg",
     "cover_image": null,
     "bio": null,
     "country": "12",
     "current_location": null,
     "status": "1",
     "lat": "",
     "lng": "",
     "created_at": "2018-08-20 14:50:39",
     "updated_at": "2018-08-28 20:31:30",
     "balance": "0",
     "login_at": "2018-08-20 15:00:44"
     */
    var id:String!
    var phone:String!
    var username:String!
    var email:String!
    var gender:String!
    var facebook_account:String!
    var instgaram_account:String!
    var twitter_account:String!
    var linkin_account:String!
    var profile_image:String!
    var cover_image:String!
    var current_location:String!
    var country:String!
    var bio:String!
    var login_at:String!
    var updated_at:String!
    var created_at:String!
   // var country:String!
    
}
