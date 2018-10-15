//
//  RefreshInformation.swift
//  StoreApp
//
//  Created by MAC on 9/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct RefreshInformationModel:Decodable {
    var status:Int!
    var message:String!
    var data:RefreshInformationCell!
    
}

struct RefreshInformationCell: Decodable {
    var username:String!
    var balance:String!
    var csutomer_ads:String!
    var status:String!
}
