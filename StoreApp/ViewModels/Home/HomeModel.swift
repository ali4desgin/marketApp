//
//  HomeModel.swift
//  StoreApp
//
//  Created by MAC on 8/27/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct  HomeModel: Decodable {
    var status: Int!
    var message: String!
    var lastst: [HomeAds]!
    var pineds: [HomeAds]!
    var suggestions: [HomeAds]!
    
}


struct HomeAds: Decodable {
    var id: String!
    var title: String!
    var description: String!
    var image: String!
    var price: String!
    var currency: String!
    var created_at: String!
    var user_image: String!
    var user_id: String!
  
}
