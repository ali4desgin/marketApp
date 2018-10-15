//
//  SubCategoryCellExtentions.swift
//  Store
//
//  Created by MAC on 8/2/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

extension SubcategoryCell :  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UINavigationControllerDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: levelcellid, for: indexPath) as! SubcatehoryLevelCell
        //cell.backgroundColor = .blue
        cell.LevelTitle.text  = levels[indexPath.row].title
        
        Alamofire.request(levels[indexPath.row].image).responseData { response in
            
            switch response.result {
                
            case .success :
                if let data = response.data {
                    cell.LevelImage.image = UIImage(data: data)
                }
                break;
                
            case .failure( let  error):
                
                break;
                
                
                
            }
            
            
            
        }
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:80, height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let vc = LevelViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.level_id = String(levels[indexPath.row].id)
        delg?.navigationController?.pushViewController(vc,animated: true)
        //       UINavigationController().pushViewController(UIViewController(), animated: true)
        //
        //
        //
        //        //print(String( indexPath.row ))
        //
        //
        //            let subcategory : SubCategoryViewController = SubCategoryViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //            subcategory.selected_level_id = String( indexPath.row )
        //            subcategory.toLevelItems()
        //
        //        //  let controller = UIViewController()
        //        // loadingProgress.show(view: self.view)
        //        //controller.category_id = String( indexPath.row )
        //        //  print(controller.category_id)
        //        //  self.subcategory.navigationController?.popViewController(animated: true)
        //           // UINavigationController().pushViewController(UIViewController(), animated: true)
        //        // self.subcategory.nav.navigationController
        //        //  nav.navigationController?.roo(controller, animated: true)
    }
    
    
}

