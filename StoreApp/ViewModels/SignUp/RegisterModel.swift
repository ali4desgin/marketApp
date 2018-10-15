//
//  RegisterModel.swift
//  StoreApp
//
//  Created by MAC on 8/29/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit


struct RegisterModel:Decodable {
    var status: Int!
    var message:String!
    var countries:[countriesModel]!
}


struct  countriesModel: Decodable {
    
    var id:String!
    var name:String!
    var flag:String!
    var currency:String!
    var code:String!
}
