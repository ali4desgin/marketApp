//
//  UserProfileViewController.swift
//  Store
//
//  Created by MAC on 8/3/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class UserProfileViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout {
    
    let cellid = "cellid"
    let headerid = "headerid"
    
    
    
    var  profile_pic_url:String!
    
    var is_myprofile = false
    let loadingProgress = LoadingProgress()
    var ads = [AdsCellModel]()
    var customer = CustomerModel()
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    
    
    var user_id = ""
    var username = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresher()
        loadData()
        print(user_id)
        collectionView?.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = main_color
        // self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: UIColor.white]
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(UserProfileCell.self, forCellWithReuseIdentifier: cellid)
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerid)
        
        self.navigationItem.title = username
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title = username
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! UserProfileCell
        // cell.backgroundColor = .orange
        
//        if ads[indexPath.row].currency == nil {
//            cell.adsPrice.text = ads[indexPath.row].price + " USD"
//        }else{
//            cell.adsPrice.text = ads[indexPath.row].price + " " +  ads[indexPath.row].currency
//        }

        if ads[indexPath.row].currency == nil {
            cell.adsPrice.text = ads[indexPath.row].price + " USD"
        }else{
            cell.adsPrice.text = ads[indexPath.row].price + " " +  ads[indexPath.row].currency
        }
        
        if let url = ads[indexPath.row].image {
            Alamofire.request(url).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        
                        if let image2 = UIImage(data: data) {
                            if let imageData = image2.jpeg(.lowest) {
                                print(imageData.count)
                                cell.adsImage.image = UIImage(data: imageData)
                            }
                        }
                        // print(data.count)
                        
                        
                        
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
        return CGSize(width: (collectionView.frame.size.width / 3 ) - 1, height: (collectionView.frame.size.width / 3 ) - 1 )
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerid, for: indexPath) as! UserProfileHeader
        
        header.delg = self
        header.backgroundColor = .white
        
        
        
        
        if is_myprofile {
            self.profile_pic_url = UserDefaults.standard.value(forKey: "profile_image")! as! String
            header.callImage.isEnabled = false
            header.followImage.isEnabled = false
            header.messageImage.isEnabled = false
            header.country.isEnabled = false
            
            header.callImage.isHidden = true
            header.followImage.isHidden = true
            header.messageImage.isHidden = true
            header.country.isHidden = true
            
            
            header.editmyprofile.isHidden = false
            header.editmyprofile.isEnabled = true
        }else{
            
            header.callImage.isEnabled = true
            header.followImage.isEnabled = true
            header.messageImage.isEnabled = true
            header.country.isEnabled = true
            
            
            header.callImage.isHidden = false
            header.followImage.isHidden = false
            header.messageImage.isHidden = false
             header.country.isHidden = false
            
            
            
            header.editmyprofile.isHidden = true
            header.editmyprofile.isEnabled = false
            
            self.profile_pic_url = customer.profile_image
        }
        
        if let url = self.profile_pic_url  {
            Alamofire.request(url).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        header.profileImage.image = UIImage(data: data)
                    }
                    break;
                    
                case .failure( let  error):
                    
                    break;

                }
                
                
                
            }
        }
        
        
        if let url = customer.cover_image  {
            Alamofire.request(url).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        header.coverImage.image = UIImage(data: data)
                    }
                    break;
                    
                case .failure( let  error):
                    
                    break;
                    
                    
                    
                }
                
                
                
            }
        }
        
        header.bio.text = customer.bio
        header.country.text = customer.current_location
        //self.navigationItem.title = customer.username
        header.username.text = customer.username
        
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 250)
    }
    
    
    
    override  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ItemDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        controller.itemid = ads[indexPath.row].id
        navigationController?.navigationBar.isHidden = false
        controller.navigationItem.title = ads[indexPath.row].title
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @objc func loadData()  {
        
        //self.loadingProgress.show(view: view)
        
        
       // let parameters: Parameters = ["category_id": category_id]
        
        
        
        self.loadingProgress.showOnWindow()
        
        Alamofire.request(webURL.customer_profile + user_id, method: .get, headers: headers).responseJSON { (response) in
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
            let result = try JSONDecoder().decode(ProfileModel.self, from: data)
            //            let alt = Alerter.make(title:"result",message: result.message);
            //            self.present(alt, animated: true, completion: nil)
           // print(result)
            
            
            if result.status == 1 {
                
                self.customer = result.customer
                self.ads = result.ads
                
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
    
    
    
    
    
    
    
}

