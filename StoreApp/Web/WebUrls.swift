//
//  Url.swift
//  Store
//
//  Created by MAC on 8/10/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class WebUrls: NSObject {
    // base url
    //let     main_domain = "http://ec2-18-191-198-252.us-east-2.compute.amazonaws.com/apis/store/";
    let     main_domain = "http://127.0.0.1/aptanaSudio/Libraries/";
    var     base_url:String!
    var     dataurl:String!
    
    
    // balance
    var    checkBalance:String!
    
    
    let headers: HTTPHeaders = [
        "Authorization": "QWxhZGRpbjpvcGVuIHNlc2FtZQ&%=#",
        "Accept": "application/json",
        "loginToken": "QWxhZGRpbjpvcGVuIHNlc2FtZQ&%=#"
    ]
    
    
    
    //http://192.168.0.102/aptanaSudio/Libraries/data/users/48/profile_image/1535619292.jpeg
    // user
    var startuser:String!
    var register:String!
    var user_files:String!
    var finishregister: String!
    var refreshinformation: String!
    var fav_list: String!
    
    
    // catogoreis
    var   catogories : String!
    var   catogories_images : String!
    var   catogory : String!
    
    // subcatogoreis
    var   subcategories : String!
   
    
    
    // ads
    var   ads : String!
    var   ad_details : String!
    var   addcomment : String!
    var publishadd:String!
    var categories_with_subcategories:String!
    var levels:String!
    
    // chats
    var chatslist: String!
    
   
    
    // countries
    var  countries : String!
    
    
    
    
    
    // profile
    var customer_profile:String!
    
    // search
    var searchsquestions:String!
    var searchitems:String!
    
    
    var home:String!
    
    
    override init() {
        super.init()
        
        base_url = self.main_domain + "api/"
        dataurl = self.main_domain + "data/"
        catogories = self.base_url + "categories/";
        catogories_images = base_url + "categories/";
        subcategories = self.base_url + "subcategories";
        ads = self.base_url + "ads/";
        ad_details = self.base_url + "ads/ad/";
        addcomment = self.base_url + "ads/addcomment/";
        customer_profile = self.base_url + "customers/profile/"
        searchsquestions = self.base_url + "ads/searchsquestions/"
        searchitems = self.base_url + "ads/search/"
        
        countries = self.base_url + "countries/"
        startuser = self.base_url + "user/start/"
        register   = self.base_url + "user/register/"
        user_files = self.dataurl +  "users/"
        finishregister = self.base_url + "user/finishregister";
        refreshinformation = self.base_url + "user/refreshinformation/"
        checkBalance = self.base_url + "user/checkbalance"
        chatslist = self.base_url + "rooms"
        fav_list = self.base_url + "user/favs"
        publishadd = self.base_url + "ads/publish"
        categories_with_subcategories = self.base_url + "ads/categories_with_subcategories"
        levels = self.base_url + "ads/levels"
        
        home = self.base_url + "home"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

