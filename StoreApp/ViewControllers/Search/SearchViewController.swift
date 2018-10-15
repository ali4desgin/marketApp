//
//  SearchViewController.swift
//  Store
//
//  Created by MAC on 8/3/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController:   UICollectionViewController  , UISearchBarDelegate  , UISearchDisplayDelegate ,UICollectionViewDelegateFlowLayout {
    
    
    
    let loadingProgress = LoadingProgress()
    var subcatogories = [SubcategoriesCell]()
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    
    var ads = [AdsCellModel]()
    
    let cellid = "cellid"
    let searchBar:UISearchBar  = {
        let bar = UISearchBar()
        bar.searchBarStyle = UISearchBarStyle.prominent
        bar.placeholder = " Search..."
        bar.sizeToFit()
        bar.isTranslucent = false
        bar.backgroundImage = UIImage()
        return bar
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresher()
        loadData()
        collectionView?.backgroundColor = .white
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.barTintColor = main_color
        self.navigationController?.navigationBar.tintColor = .white
       // navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate), landscapeImagePhone: #imageLiteral(resourceName: "home"), style: UIBarButtonItemStyle.done, target: nil, action: nil)
        collectionView?.register(LevelCell.self, forCellWithReuseIdentifier: cellid)
        
        
        
        
    
    }
  
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        
        self.loadingProgress.showOnWindow()
        
        
        let parameters: Parameters = ["keyword":textSearched]
        Alamofire.request(webURL.searchitems, method: .get,parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                //print(response.data)
                self.CustomizeLoadedData(data: response.data!)
                 self.loadingProgress.hideLoadingHubFromKeyWindow()
                break;
                
            case .failure( let  error):
                
                self.loadDone()
                 self.loadingProgress.hideLoadingHubFromKeyWindow()
                print("error in load data \(error)")
                // print(response.data ?? )
                break;
                
                
                
            }
        }
        
        print(textSearched)
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! LevelCell
        cell.backgroundColor = white_color
        
        if ads[indexPath.row].currency == nil {
            cell.adsPrice.text = ads[indexPath.row].price + " USD"
        }else{
            cell.adsPrice.text = ads[indexPath.row].price + " " +  ads[indexPath.row].currency
        }
        
        if ads[indexPath.row].pined == "0" {
            cell.pinAds.isHidden = true
            
        }
        
        if let urlloaded = ads[indexPath.row].image  {
            Alamofire.request(urlloaded).responseData { response in
        
                switch response.result {
        
                case .success :
                    if let data = response.data {
                        cell.adsImage.image = UIImage(data: data)
                    }
                    break;
        
                case .failure( let  error):
        
                    break;
        
        
        
                }
        
        
        
            }
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 1{
            
            return CGSize(width: (collectionView.frame.size.width / 1.5 ) - 1 , height: (collectionView.frame.size.width / 3 ) -  1  )
        }else if indexPath.row == 3 {
            
            return CGSize(width: (collectionView.frame.size.width / 1.5 ) - 1 , height: (collectionView.frame.size.width / 3 ) -  1  )
        }
        
        
        
        return CGSize(width: (collectionView.frame.size.width / 3 ) - 1 , height: (collectionView.frame.size.width / 3 ) -  1  )
    }
    
    
    
    
   
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //self.view.endEditing(true)
       // self.collectionView?.endEditing(true)
        self.searchBar.endEditing(true)
        
        let controller = ItemDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //loadingProgress.show(view: self.view)
        
       // self.collectionView?.endEditing(true)
        
        
        
        
        controller.itemid = String( ads[indexPath.row].id )
        
        
        
        
        if  let urlx = ads[indexPath.row].image {
            
            Alamofire.request(urlx).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        guard let  adImage  = UIImage(data: data) else { return }
                        controller.AdLoadedImage = adImage
                        
                    }
                    break;
                    
                case .failure( let  error):
                    print(error)
                    controller.AdLoadedImage = #imageLiteral(resourceName: "addphoto")
                    break;
                    
                    
                    
                }
                
                
                
            }
        }else{
            controller.AdLoadedImage = #imageLiteral(resourceName: "addphoto")
        }
        
        
        
    

    
        controller.item_title = String( ads[indexPath.row].title )
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func loadData()  {
        
        //self.loadingProgress.show(view: view)
        
        
        // let parameters: Parameters = ["category_id": category_id]
        
        
         self.loadingProgress.showOnWindow()
        Alamofire.request(webURL.searchsquestions, method: .get, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                //print(response.data)
                self.CustomizeLoadedData(data: response.data!)
                break;
                
            case .failure( let  error):
                
                self.loadDone()
                
                print("error in load data \(error)")
                // print(response.data ?? )
                break;
                
                
                
            }
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    private func CustomizeLoadedData(data: Data){
        
        
        do {
            let result = try JSONDecoder().decode(SearchModel.self, from: data)
            //            let alt = Alerter.make(title:"result",message: result.message);
            //            self.present(alt, animated: true, completion: nil)
            // print(result)
            
            
            if result.status == 1 {
                
//                self.customer = result.customer
                self.ads = result.ads
//
                //                self.subcatogories = result.subcategories
                loadDone()
                
                
            }else{
                
                let alt = Alerter.make(title:"Error",message: result.message);
                self.present(alt, animated: true, completion: nil)
            }
            
            
        }
        catch {
            
            let alt = Alerter.make(title:"result",message: "connection error \(error)");
            self.present(alt, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    
    
    func loadDone(){
        
        self.refresher.endRefreshing()
        self.loadingProgress.hideLoadingHubFromKeyWindow()
        self.collectionView?.refreshControl?.endRefreshing()
        self.collectionView?.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    
    
    
    func setupRefresher()
    {
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = main_color
        self.refresher.addTarget(self, action: #selector(loadData), for:   .valueChanged)
        self.collectionView?.addSubview(refresher)
        
    }
    
    
    
    
    
    
    
    //    func getCellSize(number:Int) -> CGSize {
    //        switch number {
    //        case 1:
    //            return CGSize(width: (collectionView!.frame.size.width / 3 ) - 1 , height: (collectionView!.frame.size.width / 3 ) -  1  )
    //        case 2:
    //            return CGSize(width: (collectionView!.frame.size.width / 2 ) - 1 , height: (collectionView!.frame.size.width / 2 ) -  1  )
    //
    //        case 3:
    //            return CGSize(width: (collectionView!.frame.size.width / 4 ) - 1 , height: (collectionView!.frame.size.width / 4 ) -  1  )
    //        case 4:
    //            return CGSize(width: (collectionView!.frame.size.width  )  , height: (collectionView!.frame.size.width / 2 ) )
    //        default:
    //            return CGSize(width: (collectionView!.frame.size.width / 3 ) - 1 , height: (collectionView!.frame.size.width / 3 ) -  1  )
    //        }
    //    }
    
}

