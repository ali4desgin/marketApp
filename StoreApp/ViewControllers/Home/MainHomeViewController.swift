//
//  MainHomeViewController.swift
//  StoreApp
//
//  Created by MAC on 9/16/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire

class MainHomeViewController: UIViewController , UITableViewDelegate ,  UITableViewDataSource
, UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {


    
    let collectioncellid = "collectiocellid"
    let tablecellid = "tablecellid"
    var tableItems:[[HomeAds]] = []
    let loadingProgress = LoadingProgress()
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    var collectionItems = [HomeAds]()
    
    
    
    
    let collection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let element = UICollectionView(frame: CGRect(), collectionViewLayout:flowLayout)
        element.backgroundColor = UIColor.white
        return element
    }()
    
    
    
    let table: UITableView = {
        let element = UITableView()
        return element
    }()
    
    let sepLine: UIView = {
        let element = UIView()
        element.backgroundColor = so_light_gray
        return element
    }()
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        view.backgroundColor = .white
        setupRefresher()
        loadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    fileprivate func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = main_color
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.tintColor = white_color
        self.navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: UIColor.white]

    }

    fileprivate func setupViews(){
        view.addSubview(collection)
        view.addSubview(sepLine)
        view.addSubview(table)
        
        collection.delegate = self
        collection.dataSource = self
        
        table.delegate = self
        table.dataSource = self
        
        
        collection.register(SubHomeCollectionViewCell.self , forCellWithReuseIdentifier: collectioncellid)
        table.register(HomeTableViewCell.self , forCellReuseIdentifier: tablecellid)
        
        
        let navh = self.navigationController?.navigationBar.frame.height
        collection.anchor(view.topAnchor, left: view.leftAnchor, bottom: sepLine.topAnchor, right: view.rightAnchor, topConstant: navh!, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 170)
        
        sepLine.anchor(collection.bottomAnchor, left: view.leftAnchor, bottom: table.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
        table.anchor(sepLine.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    
    
     // collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectioncellid, for: indexPath) as! SubHomeCollectionViewCell

                //cell.backgroundColor = .blue
                cell.ads_title.text = collectionItems[indexPath.row].title
                cell.ads_price.text = collectionItems[indexPath.row].price + " " + collectionItems[indexPath.row].currency
                cell.ads_description.text = collectionItems[indexPath.row].description




                if let urlloaded = collectionItems[indexPath.row].image  {
                    Alamofire.request(urlloaded).responseData { response in

                        switch response.result {

                        case .success :
                            if let data = response.data {
                                cell.ads_image.image = UIImage(data: data)
                            }
                            break;

                        case .failure( let  error):

                            break;



                        }



                    }
                }
        
        
        
        //print("user image \(collectionItems[indexPath.row].user_image)")
        if let userImage = collectionItems[indexPath.row].user_image  {
            Alamofire.request(userImage).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        cell.user_image.image = UIImage(data: data)
                    }
                    break;
                    
                case .failure:
                    
                    break;
                    
                    
                    
                }
                
                
                
            }
        }
        
        




        
            return cell
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 110)
    }


    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc =  ItemDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.itemid = collectionItems[indexPath.row].id
        vc.item_title = collectionItems[indexPath.row].title
        if let urlloaded = collectionItems[indexPath.row].image  {
            Alamofire.request(urlloaded).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        vc.AdLoadedImage = UIImage(data: data)
                    }
                    break;
                    
                case .failure( let  error):
                    
                    break;
                    
                    
                    
                }
                
                
                
            }
        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems[section].count
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: tablecellid, for: indexPath) as! HomeTableViewCell
        cell.backgroundColor = .white
        
        
        
        cell.ads_title.text = tableItems[indexPath.section][indexPath.row].title
        cell.ads_description.text = tableItems[indexPath.section][indexPath.row].description
        cell.ads_price.text = tableItems[indexPath.section][indexPath.row].price + " " + tableItems[indexPath.section][indexPath.row].currency


        if let urlloaded = tableItems[indexPath.section][indexPath.row].image  {
            Alamofire.request(urlloaded).responseData { response in

                switch response.result {

                case .success :
                    if let data = response.data {
                        cell.ads_image.image = UIImage(data: data)
                    }
                    break;

                case .failure( let  error):

                    break;



                }



            }
        }

        
        
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
    

            let header = UIView()
            header.backgroundColor = so_light_gray
            let label = UILabel()
            label.text = "Suggestions"
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 14)
            header.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints  = false
            [label.topAnchor.constraint(equalTo: header.topAnchor, constant: 0),
                label.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 8),
                label.rightAnchor.constraint(equalTo: header.rightAnchor, constant: 0),
                label.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: 0),
                ].forEach({ $0.isActive = true })
    
    
    
            return header
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc =  ItemDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.itemid = tableItems[indexPath.section][indexPath.row].id
        vc.item_title = tableItems[indexPath.section][indexPath.row].title
        if let urlloaded = tableItems[indexPath.section][indexPath.row].image  {
            Alamofire.request(urlloaded).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        vc.AdLoadedImage = UIImage(data: data)
                    }
                    break;
                    
                case .failure( let  error):
                    
                    break;
                    
                    
                    
                }
                
                
                
            }
        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 50
    }
  
    
    
    
    
        @objc func loadData()  {
    
            let parameters: Parameters = ["category_id": "1"]
    
    
    
            self.loadingProgress.showOnWindow()
    
            Alamofire.request(webURL.home, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
    
                case .success :
                   // print(response.data)
                    self.CustomizeLoadedData(data: response.data!)
                    break;
    
                case .failure( let  error):
                    self.loadDone()
                //    print("error in load data \(error)")
                    // print(response.data ?? )
                    break;
    
    
    
                }
            }
    
    
    
    
    
        }
    
    
    
    
    
    
        private func CustomizeLoadedData(data: Data){
    
    
            do {
                let result = try JSONDecoder().decode(HomeModel.self, from: data)
                //            let alt = Alerter.make(title:"result",message: result.message);
                //            self.present(alt, animated: true, completion: nil)
           //     print(result)
    
    
                if result.status == 1 {
    
                    self.collectionItems = result.pineds
                    self.tableItems = [result.lastst,result.suggestions]
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
            self.table.refreshControl?.endRefreshing()
            self.table.reloadData()
            self.collection.refreshControl?.endRefreshing()
            self.collection.reloadData()
    
        }
    
    
    
        func setupRefresher()
        {
            self.refresher = UIRefreshControl()
            self.refresher.tintColor = main_color
            self.refresher.addTarget(self, action: #selector(loadData), for:   .valueChanged)
            self.table.addSubview(refresher)
           // self.collection.addSubview(refresher)
    
        }
    
    
    
    

}
