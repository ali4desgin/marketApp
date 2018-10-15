////
////  HomeViewController.swift
////  Store
////
////  Created by MAC on 7/30/18.
////  Copyright © 2018 app. All rights reserved.
////
//
//import UIKit
//import Alamofire
//
//class HomeViewController: UITableViewController   {
//  
//    
//    
//    let cellid = "cellid"
//    let loadingProgress = LoadingProgress()
//    var refresher:UIRefreshControl!
//    let webURL = WebUrls()
//    var piends_up = [HomeAds]()
////    var lastest = [HomeAds]()
////    var suggestions = [HomeAds]()
////
//    
//    var items:[[HomeAds]] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupRefresher()
//        loadData()
//        setupNavigationBar()
//        tableView.register(HomeTableViewCell.self , forCellReuseIdentifier: cellid)
//        
//      //  tableView.separatorStyle = .none
//        
//      
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        
////        if let count = items.count {
////            return count
////        }
//        
//        return items.count
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    
////        if section == 0{
////            return lastest.count
////        }
//        
//        return items[section].count
//    }
//    
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell =  tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! HomeTableViewCell
//        
////
////        // cell.semanticContentAttribute = .forceRightToLeft
////        //|| (indexPath.section == 1  && indexPath.row == 0)
////        if (indexPath.section == 0  && indexPath.row == 0)  {
////
//////            cell.view_all.anc
////
////            cell.items = piends_up
////
////
////            cell.pined_ads.anchor(cell.topAnchor, left: cell.leftAnchor, bottom: cell.collection.topAnchor, right: nil, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 20)
////
////
////            cell.view_all.anchor(cell.topAnchor, left: nil, bottom: cell.collection.topAnchor, right: cell.rightAnchor, topConstant: 5, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 20)
////
////            cell.collection.anchor(cell.pined_ads.bottomAnchor, left: cell.leftAnchor, bottom: cell.bottomAnchor, right: cell.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 80)
////            cell.collection.isHidden = false
////            cell.view_all.isHidden = false
////            cell.pined_ads.isHidden = false
////            cell.ads_image.isHidden = true
////            cell.ads_title.isHidden = true
////            cell.ads_description.isHidden = true
////            cell.ads_price.isHidden = true
////
////        }else{
////            cell.ads_price.isHidden = false
////          //  cell.collection.isHidden = true
////         //   cell.view_all.isHidden = true
////         //   cell.pined_ads.isHidden = true
////            cell.ads_image.isHidden = false
////            cell.ads_title.isHidden = false
////            cell.ads_description.isHidden = false
////            cell.ads_image.anchor(cell.topAnchor, left: cell.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
////            cell.ads_title.anchor(cell.topAnchor, left: cell.ads_image.rightAnchor, bottom: nil, right: cell.rightAnchor, topConstant: 18, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
////            
////            
////            cell.ads_price.anchor(cell.topAnchor, left: nil, bottom: cell.ads_description.topAnchor, right: cell.rightAnchor, topConstant: 18, leftConstant: 4, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
////            
////            
////            
////            cell.ads_description.anchor(cell.ads_title.bottomAnchor, left: cell.ads_image.rightAnchor, bottom: cell.bottomAnchor, right: cell.rightAnchor, topConstant: -2, leftConstant: 4, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
////            
////            
//            
//            cell.ads_title.text = items[indexPath.section][indexPath.row].title
//            cell.ads_description.text = items[indexPath.section][indexPath.row].description
//            cell.ads_price.text = items[indexPath.section][indexPath.row].price + " " + items[indexPath.section][indexPath.row].currency
//            
//            
//            if let urlloaded = items[indexPath.section][indexPath.row].image  {
//                Alamofire.request(urlloaded).responseData { response in
//
//                    switch response.result {
//
//                    case .success :
//                        if let data = response.data {
//                            cell.ads_image.image = UIImage(data: data)
//                        }
//                        break;
//
//                    case .failure( let  error):
//
//                        break;
//
//
//
//                    }
//
//
//
//                }
//            }
//            
//           
//            
//            
//   //     }
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        return cell
//    }
//    
//    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//    
//        
////        if section == 0 {
////
////            return UIView()
////        }
//        let header = UIView()
//        header.backgroundColor = so_light_gray
//        let label = UILabel()
//        label.text = "Suggestions"
//        label.textColor = .gray
//        label.font = UIFont.systemFont(ofSize: 14)
//        header.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints  = false
//        [label.topAnchor.constraint(equalTo: header.topAnchor, constant: 0),
//            label.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 8),
//            label.rightAnchor.constraint(equalTo: header.rightAnchor, constant: 0),
//            label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: 0),
//            ].forEach({ $0.isActive = true })
//        
//        
//        
//        return header
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//      //|| (indexPath.section == 1  && indexPath.row == 0)
////        if (indexPath.section == 0  && indexPath.row == 0)  {
////
////            return 150
////        }
//        return   80
//    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
////        if section == 0 {
////
////            return 0
////        }
//        return 50
//    }
//    fileprivate func setupNavigationBar(){
//        self.navigationController?.navigationBar.barTintColor = main_color
//        self.navigationItem.title = "Home"
//        self.navigationController?.navigationBar.tintColor = white_color
//        self.navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: UIColor.white]
//       
//    }
//    
//    
//    
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let vc = ItemDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
//      //  vc.navigationItem.title = items[indexPath.section][indexPath.row].title
//        vc.itemid = items[indexPath.section][indexPath.row].id
//        
//        if let urlloaded = items[indexPath.section][indexPath.row].image  {
//            Alamofire.request(urlloaded).responseData { response in
//                
//                switch response.result {
//                    
//                case .success :
//                    if let data = response.data {
//                        vc.AdLoadedImage = UIImage(data: data)
//                    }
//                    break;
//                    
//                case .failure( let  _):
//                    
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
//        
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
//            
//            
//            
//    
//    
//    
//    @objc func loadData()  {
//        
//        // self.loadingProgress.show(view: view)
//        
//        
//        let parameters: Parameters = ["category_id": "1"]
//        
//        
//        
//        self.loadingProgress.showOnWindow()
//        
//        Alamofire.request(webURL.home, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
//            switch response.result {
//                
//            case .success :
//               // print(response.data)
//                self.CustomizeLoadedData(data: response.data!)
//                break;
//                
//            case .failure( let  error):
//                self.loadDone()
//                print("error in load data \(error)")
//                // print(response.data ?? )
//                break;
//                
//                
//                
//            }
//        }
//        
//        
//        
//        
//        
//    }
//    
//    
//    
//    
//    
//    
//    private func CustomizeLoadedData(data: Data){
//        
//        
//        do {
//            let result = try JSONDecoder().decode(HomeModel.self, from: data)
//            //            let alt = Alerter.make(title:"result",message: result.message);
//            //            self.present(alt, animated: true, completion: nil)
//            print(result)
//            
//            
//            if result.status == 1 {
//                
//                self.piends_up = result.pineds
//                self.items = [result.lastst,result.suggestions]
//                loadDone()
//                
//                
//            }else{
//                
//                let alt = Alerter.make(title:"Error",message: result.message);
//                self.present(alt, animated: true, completion: nil)
//            }
//            
//            
//        }
//        catch {
//            
//            let alt = Alerter.make(title:"result",message: "connection error \(error)");
//            self.present(alt, animated: true, completion: nil)
//        }
//        
//        
//        
//    }
//    
//    
//    
//    
//    
//    func loadDone(){
//        
//        self.refresher.endRefreshing()
//        self.loadingProgress.hideLoadingHubFromKeyWindow()
//        self.tableView.refreshControl?.endRefreshing()
//        self.tableView.reloadData()
//        
//    }
//    
//    
//    
//    func setupRefresher()
//    {
//        self.refresher = UIRefreshControl()
//        self.refresher.tintColor = main_color
//        self.refresher.addTarget(self, action: #selector(loadData), for:   .valueChanged)
//        self.tableView.addSubview(refresher)
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//}
//
