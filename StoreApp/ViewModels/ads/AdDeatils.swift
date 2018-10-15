//
//  AdDeatils.swift
//  StoreApp
//
//  Created by MAC on 8/28/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct  AdDeatils: Decodable {
    var status: Int!
    var message: String!
    var ad: Ad!
    var customer: AdCustomer!
    var comments: [AdComments]!
}

struct Ad:Decodable {
    var  id:String!
    var  level_id:String!
    var  customer_id:String!
    var  title:String!
    var  description:String!
    var  price:String!
    var  currency:String!
    var  status:String!
    var  image:String!
    var  created_at:String!
    var  updated_at:String!
}


struct AdCustomer:Decodable {
    
    var id:String!
    var phone:String!
    var username:String!
    var email:String!
    var gender:String!
    var facebook_account:String!
    var instgaram_account:String!
    var twitter_account:String!
    var profile_image:String!
    var country:String!
    
}

struct AdComments:Decodable {
    
    var id:String!
    var customer_id:String!
    var ad_id:String!
    var comment_id:String!
    var content:String!
    var created_at:String!
    var updated_at:String!
}
