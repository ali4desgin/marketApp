//
//  LevelViewController.swift
//  Store
//
//  Created by MAC on 8/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class LevelViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var level_id = ""
    let cellid = "cellid"
    
    
    let loadingProgress = LoadingProgress()
    var subcatogories = [SubcategoriesCell]()
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    
    var ads = [AdsCellModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresher()
        loadData()
        
        
        collectionView?.backgroundColor = .white
        collectionView?.register(LevelCell.self , forCellWithReuseIdentifier: cellid)
        collectionView?.alwaysBounceVertical = true
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = ItemDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        //loadingProgress.show(view: self.view)
        controller.itemid = String( ads[indexPath.row].id )
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! LevelCell
        if ads[indexPath.row].currency == nil {
            cell.adsPrice.text = ads[indexPath.row].price + " USD"
        }else{
            cell.adsPrice.text = ads[indexPath.row].price + " " +  ads[indexPath.row].currency
        }
        
        
        if ads[indexPath.row].pined == "0" {
            cell.pinAds.isHidden = true
            
        }
        
        if let urlx =  ads[indexPath.row].image {
            Alamofire.request(urlx).responseData { response in
                
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 , height:  collectionView.frame.size.width / 3 - 1)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    @objc func loadData()  {
        
        
       
        
        
        let parameters: Parameters = ["level_id": level_id]
        
        
        self.loadingProgress.showOnWindow()
        
        Alamofire.request(webURL.ads, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                print(response.data)
                self.CustomizeLoadedData(data: response.data!)
                break;
                
            case .failure( let  error):
                //self.loadDone()
                print("error in load data \(error)")
                // print(response.data ?? )
                break;
                
                
                
            }
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    private func CustomizeLoadedData(data: Data){
        
        
        do {
            let result = try JSONDecoder().decode(AdsModel.self, from: data)
            //            let alt = Alerter.make(title:"result",message: result.message);
            //            self.present(alt, animated: true, completion: nil)
           // print(result)
            
            
            if result.status == 1 {
                self.ads = result.ads
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
        collectionView?.alwaysBounceVertical = true
    }
    
    
    
}

