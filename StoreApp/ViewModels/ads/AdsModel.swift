//
//  AdsModel.swift
//  StoreApp
//
//  Created by MAC on 8/28/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit

struct AdsModel: Decodable {
    var status: Int!
    var message:String!
    var ads:[AdsCellModel]!
    
}

struct AdsCellModel:Decodable {
    
    var id: String!
    var level_id:String!
    var customer_id: String!
    var title: String!
    var description: String!
    var price: String!
    var currency: String!
    var image: String!
    var pined: String!
    var updated_at: String!
    var status: String!
    var created_at: String!
    
}
