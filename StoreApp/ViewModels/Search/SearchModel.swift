//
//  SearchModel.swift
//  StoreApp
//
//  Created by MAC on 8/29/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct SearchModel: Decodable {
    var status:Int!
    var message:String!
    var ads:[AdsCellModel]!
    
}
