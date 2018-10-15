//
//  SucategoriesModel.swift
//  StoreApp
//
//  Created by MAC on 8/27/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit

struct SubcategoriesModel: Decodable {
    var status: Int!
    var message: String!
    var subcategories: [SubcategoriesCell]!
}
//
struct  SubcategoriesCell: Decodable {

    var id: String!
    var title: String!
    var levels: [LevelsModel]!
}
//
//
struct LevelsModel: Decodable {
    var id: String!
    var subcategory_id: String!
    var title: String!
    var description: String!
    var image: String!
    var status: String!
    var created_at: String!
}

