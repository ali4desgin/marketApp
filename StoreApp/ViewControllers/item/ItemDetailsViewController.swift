//
//  ItemDetailsViewController.swift
//  Store
//
//  Created by MAC on 7/31/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class ItemDetailsViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var headerHiegth:CGFloat = 400
    var itemid = ""
    let item_headerid = "item_headerid"
    let item_cellid = "item_cellid"
    var item_title = "Item For SALE"
    var AdLoadedImage:UIImage!
    let loadingProgress = LoadingProgress()
    var comments = [AdComments]()
    var customer = AdCustomer()
    var ad = Ad()
    
    
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    
    
    var toProfileActivity = 0
    public var navigator : UINavigationController!
    
    //var item = HomeAds()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefresher()
        loadData()
        navigator = self.navigationController;
        collectionView?.alwaysBounceVertical = true
        // collection view registered ids
        collectionView?.backgroundColor = .white
        collectionView?.register(ItemCommentsCell.self, forCellWithReuseIdentifier: item_cellid)
        collectionView?.register(ItemDetailsHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: item_headerid )
        // self.navigationController?.navigationBar.isHidden = true
        navigationItem.title = ad.price
//        if ad.title == nil  || ad.title == "" {
//            navigationItem.title = ad.price
//        }else{
//            navigationItem.title = ad.title
//        }
//
        
        self.navigationItem.title = item_title
        
        
        
    }
    
//
//    fileprivate func loadImage(adimageurl:String){
//
//
//        if adimageurl != nil {
//
//            Alamofire.request(adimageurl).responseData { response in
//
//                switch response.result {
//
//                case .success :
//                    if let data = response.data {
//                        guard let  adImage  = UIImage(data: data) else { return }
//                        self.AdLoadedImage = adImage
//
//                    }
//                    break;
//
//                case .failure( let  error):
//                    print(error)
//                     self.AdLoadedImage = #imageLiteral(resourceName: "addphoto")
//                    break;
//
//
//
//                }
//
//
//
//            }
//        }else{
//            AdLoadedImage = #imageLiteral(resourceName: "addphoto")
//        }
//
//
//
//    }
//
//
    
    override func viewDidAppear(_ animated: Bool) {
        if toProfileActivity == 1 {
            toProfile(userid:customer.id)
        }
    }
    
    public func  toProfile(userid:String) {
//        let vc = UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        vc.user_id =  userid
//        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    
    // start collection  functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item_cellid, for: indexPath) as! ItemCommentsCell
        //cell.backgroundColor = .red
        cell.CommentConetent.text  = comments[indexPath.row].content
        cell.CommentDate.text = comments[indexPath.row].created_at
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height:CGFloat = 400
        if let image = AdLoadedImage {
            height = collectionView.frame.width / image.size.width *  image.size.height + 140
        }else{
             height = 400
        }
        
        
        
        return CGSize(width: collectionView.frame.size.width, height: height )
    }
    
    
    
    // header and footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: item_headerid, for: indexPath) as! ItemDetailsHeaderCell
        
        
        if ad.currency == nil {
            header.adsPrice.text =  ad.price
        }else{
            header.adsPrice.text = ad.price + " " +  ad.currency
        }
        
//
//        if ad.image != nil {
//            Alamofire.request(ad.image).responseData { response in
//
//                switch response.result {
//
//                case .success :
//                    if let data = response.data {
//                         guard let  adImage  = UIImage(data: data) else { return }
//                        //let adImage = UIImage(data: data)
        
                        var height:CGFloat = 400
                        if let image = AdLoadedImage {
                            height = header.frame.width / AdLoadedImage.size.width * AdLoadedImage.size.height
                        }else{
                            height = 270
                        }
        

                        //header.adImage.frame = CGRect(x: 0, y: 0, width:  100, height: 100)
        
                        header.adImage.anchor(header.upperTab.bottomAnchor, left: header.leftAnchor, bottom: nil, right: header.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: header.frame.width, heightConstant: height)
                        
                        header.adImage.contentMode = .scaleAspectFit
                        
                        
                        header.adImage.image = AdLoadedImage
                        
                       
//                    }
//                    break;
//
//                case .failure( let  error):
//                        print(error)
//                    break;
//
//
//
//                }
//
//
//
//            }
//        }
//

        
        
       // print(customer.profile_image)
        if customer.profile_image != nil {
            Alamofire.request(customer.profile_image).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        guard let  headerImage  = UIImage(data: data) else { return }
                        
//                        let hieght = header.frame.width / headerImage.size.width * headerImage.size.height
//
//                        header.profileImage.frame = CGRect(x: 0, y: 0, width:  header.frame.width, height: hieght)
//
//                        header.profileImage.contentMode = .scaleAspectFit
                        header.profileImage.image = headerImage
                    }
                    break;
                    
                    case .failure( let  error):
                        print(error)
                    break;
                    
                    
                    
                }
                
                
                
            }
        }
        
        
        
      //  header.adsPrice.text = ad.price
        print(customer.phone)
        if let ph = customer.phone {
            header.customer_phone = ph
        }else{
          // header.callImage.isHidden = true
        }
        
        
        header.customer_id = customer.id
        header.ad_id = ad.id
        header.username = customer.username
        header.usernameLbl.setTitle(customer.username, for: []) 
        header.backgroundColor = UIColor(white: 0.90, alpha: 1)
        header.del = self
        return header
        
    }
    
    
    
    
    @objc func loadData()  {
        
        
        
        //self.loadingProgress.show(view: view)
        
        
        let parameters: Parameters = ["ad_id": itemid]
        
        
        
        self.loadingProgress.showOnWindow()
        
        Alamofire.request(webURL.ad_details, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
               // print(response.data)
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
            let result = try JSONDecoder().decode(AdDeatils.self, from: data)
           
            
            
            if result.status == 1 {
               // self.ads = result.ads
                self.ad = result.ad
                self.customer = result.customer
                self.comments = result.comments
                
                print(result)
               // loadImage(adimageurl:ad.image)
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

