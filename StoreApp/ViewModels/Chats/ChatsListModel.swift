//
//  ChatsListModel.swift
//  StoreApp
//
//  Created by MAC on 9/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct  ChatsListModel: Decodable {
    var status: Int!
    var message: String!
    var rooms: [RoomCell]!
}


struct  RoomCell: Decodable {
    var id: String!
    var updated_at: String!
    var with:RoomWithCell!
    var last_message:RoomLastMessageCell!
    
}

struct RoomWithCell:Decodable {
    var  username:String!
    var  profile_image:String!
    var  created_at:String!
    
}

struct RoomLastMessageCell:Decodable {
    var  message:String!
    var  is_readed:String!
    
}


