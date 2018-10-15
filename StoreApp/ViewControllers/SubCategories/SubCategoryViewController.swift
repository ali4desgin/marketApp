//
//  SubCategoryViewController.swift
//  Store
//
//  Created by MAC on 8/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Alamofire



class SubCategoryViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout {
    
    
    var selected_level_id = ""
    var category_id = ""
    let cellid = "cellid"
    let headerid = "headerid"
    
    
    
    let loadingProgress = LoadingProgress()
    var subcatogories = [SubcategoriesCell]()
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresher()
        loadData()
      //  print("category id\(category_id)")
       
        
        self.navigationController?.navigationBar.tintColor = white_color
        self.navigationController?.navigationBar.topItem?.title = ""
        collectionView?.backgroundColor = white_color
        collectionView?.register(SubcategoryHeader.self , forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerid)
        view.backgroundColor = white_color
        collectionView?.register(SubcategoryCell.self, forCellWithReuseIdentifier: cellid)
        navigationItem.title = "Subcategory"
        //  collectionView?.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        collectionView?.alwaysBounceVertical = true
        // collectionView?.isScrollEnabled = false
        
        
    }
    
    public  func toLevelItems( )  {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcatogories.count
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! SubcategoryCell
        // cell.backgroundColor = .red
        cell.delg = self
        cell.subcategoryTitle.text = subcatogories[indexPath.row].title
        cell.levels = subcatogories[indexPath.row].levels
        return cell
    }
    
    
    //    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        print(selected_level_id)
    //        self.present(ForgetPasswordViewController(), animated: true, completion: nil)
    //      self.navigationController?.pushViewController(UIViewController(), animated: true)
    //    }
    //
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 140)
    }
    
    
    
    
    
    
    @objc func loadData()  {
        
       // self.loadingProgress.show(view: view)
        
        
        let parameters: Parameters = ["category_id": category_id]
      
        
        
        self.loadingProgress.showOnWindow()
        
        Alamofire.request(webURL.subcategories, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                print(response.data)
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
            let result = try JSONDecoder().decode(SubcategoriesModel.self, from: data)
            //            let alt = Alerter.make(title:"result",message: result.message);
            //            self.present(alt, animated: true, completion: nil)
            print(result)
            
            
            if result.status == 1 {

                self.subcatogories = result.subcategories
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

