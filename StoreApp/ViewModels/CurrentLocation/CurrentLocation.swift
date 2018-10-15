//
//  CurrentLocation.swift
//  StoreApp
//
//  Created by MAC on 8/30/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
struct CurrentLocationModel: Decodable {
    /*
     "as": "AS36998 Mobitel (Sudanese Mobile Telephone Co Ltd aka ZAIN)",
     "city": "Khartoum",
     "country": "Sudan",
     "countryCode": "SD",
     "isp": "Mobitel (Sudanese Mobile Telephone Co Ltd aka ZAIN",
     "lat": 15.5007,
     "lon": 32.5599,
     "org": "Mobitel (Sudanese Mobile Telephone Co Ltd aka ZAIN",
     "query": "154.97.153.26",
     "region": "KH",
     "regionName": "Khartoum",
     "status": "success",
     "timezone": "Africa/Khartoum",
     "zip": """;
     }
     */
    
    var `as`:String!
    var city:String!
    var country:String!
    var countryCode:String!
    var isp:String!
    var lat:CGFloat!
    var lon:CGFloat!
    var query:String!
    var region:String!
    var regionName:String!
    var status:String!
    var timezone:String!
    var zip:String!
    
}
