//
//  LevelModelForNewAd.swift
//  StoreApp
//
//  Created by MAC on 9/12/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit

struct LevelModelForNewAd:Decodable {
    var status:Int!
    var message:String!
    var levels:[LevelCellModelForNew]!
    
}


struct LevelCellModelForNew:Decodable {
    var id:String!
    var title:String!
   
}


