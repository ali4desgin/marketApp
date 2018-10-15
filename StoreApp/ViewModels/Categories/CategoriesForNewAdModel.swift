//
//  CategoriesForNewAdModel.swift
//  StoreApp
//
//  Created by MAC on 9/12/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct ChooseCategoriesForNewAdModel:Decodable {
    var status:Int!
    var id:String!
    var title:String!
    var message:String!
    var categories:[categoriesForNewAd]!
   
}


struct categoriesForNewAd:Decodable {
    var id:String!
    var title:String!
    var subcategories:[subcategoriesForNewAd]!
}


struct subcategoriesForNewAd:Decodable {
    var id:String!
    var title:String!
    var message:String!
}


