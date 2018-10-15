//
//  Alerter.swift
//  StoreApp
//
//  Created by MAC on 8/27/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class  Alerter: NSObject {
    
    
   public   static func make(title:String,message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(ok)
        return alert
    }
}

