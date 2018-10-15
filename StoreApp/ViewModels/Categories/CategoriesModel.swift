//
//  CategoriesModel.swift
//  StoreApp
//
//  Created by MAC on 8/27/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct CategoriesModel: Decodable {
    var status: Int!
    var message: String!
    var categories: [CategoriesModelCell]!
}

struct  CategoriesModelCell: Decodable {
    var id: String!
    var title: String!
    var description: String!
    var image: String!
    var status: String!
    var updated_at: String!
    var created_at: String!
    var subcategories_count: String!
}
