//
//  MainTabBar.swift
//  StoreApp
//
//  Created by MAC on 8/27/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class MainTabBar: UITabBarController {

    
    
    override func viewDidLoad() {
        
        if #available(iOS 10.0, *) {
            print("Avaliable ios 10.0")
            self.tabBar.unselectedItemTintColor = UIColor.gray
        } else {
            // Fallback on earlier versions
        }
        
        let homeNav = UINavigationController(rootViewController: MainHomeViewController())
        homeNav.tabBarItem.image =  #imageLiteral(resourceName: "ic_home_36pt").withRenderingMode(.alwaysTemplate)
        homeNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "ic_home_white_36pt").withRenderingMode(.alwaysTemplate)
        homeNav.tabBarController?.tabBar.barTintColor = main_color

        
        
        let category =  UINavigationController(rootViewController: CategoriesViewController())
        
        category.tabBarItem.image = #imageLiteral(resourceName: "ic_format_list_bulleted_36pt").withRenderingMode(.alwaysTemplate)
        category.tabBarItem.selectedImage = #imageLiteral(resourceName: "ic_format_list_bulleted_white_36pt").withRenderingMode(.alwaysTemplate)
        category.tabBarController?.tabBar.barTintColor = main_color

        
        let search =  UINavigationController(rootViewController: SearchViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        search.tabBarItem.image = #imageLiteral(resourceName: "ic_search_36pt").withRenderingMode(.alwaysTemplate)
        search.tabBarItem.selectedImage = #imageLiteral(resourceName: "ic_search_white_36pt").withRenderingMode(.alwaysTemplate)
        search.tabBarController?.tabBar.barTintColor = main_color

        
        
        
        
        let user_profile = UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        user_profile.is_myprofile = true
        if let id = UserDefaults.standard.value(forKey: "id")  {
            user_profile.user_id = id as! String
        }
        
        
        let setting = UINavigationController(rootViewController: SideMenViewController())
        setting.tabBarItem.image = #imageLiteral(resourceName: "user1").withRenderingMode(.alwaysTemplate)
        setting.tabBarItem.selectedImage = #imageLiteral(resourceName: "user1").withRenderingMode(.alwaysTemplate)
        setting.tabBarController?.tabBar.barTintColor = main_color

  
        
        
        
        let addnewad = UINavigationController(rootViewController: NewAdViewController())
        addnewad.tabBarItem.image = #imageLiteral(resourceName: "ic_add_a_photo_36pt").withRenderingMode(.alwaysTemplate)
        addnewad.tabBarItem.image = #imageLiteral(resourceName: "ic_add_a_photo_white_36pt").withRenderingMode(.alwaysTemplate)
        addnewad.tabBarItem.badgeColor = UIColor.red
        addnewad.tabBarController?.tabBar.barTintColor = main_color
       
        
        self.tabBar.barTintColor = so_light_gray
        self.tabBar.tintColor = barTinyColor
        viewControllers = [homeNav,search, addnewad,category,setting]
    }
   

}
