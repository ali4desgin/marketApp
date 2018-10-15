//
//  CategoriesViewController.swift
//  Store
//
//  Created by MAC on 7/30/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import FontAwesome_swift
import  Alamofire

class CategoriesViewController: UITableViewController  {
    let cellid = "cellid"
    let categories = ["Cars","Users","FootBall"]
    let loadingProgress = LoadingProgress()
    var catogories = [CategoriesModelCell]()
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        setupRefresher()
        
        tableView?.backgroundColor = .white
        tableView.register(CategoryCell.self , forCellReuseIdentifier: cellid)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = main_color
        setupNavigation()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    
    func setupRefresher()
    {
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = main_color
        self.refresher.addTarget(self, action: #selector(loadData), for:   .valueChanged)
        self.tableView!.addSubview(refresher)
        
    }
    
    
    
    func setupNavigation(){
        
       
        
        navigationItem.title = "Main Categories"
        
        self.navigationController?.navigationBar.titleTextAttributes =  [.foregroundColor: UIColor.white]
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Main Categories"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catogories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellid) as! CategoryCell
        
        cell.categoryTitle.text = catogories[indexPath.row].title
        cell.categoryDescription.text = catogories[indexPath.row].description
       // cell.categoryNumberOFSubCategories.text =
        cell.categoryNumberOFSubCategories.text = catogories[indexPath.row].subcategories_count
        //cell.categoryImage.image = catogories[indexPath.row].image as! String
        //print(catogories[indexPath.row].image)
        Alamofire.request(catogories[indexPath.row].image).responseData { response in
            
            switch response.result {
                
            case .success :
                if let data = response.data {
                    cell.categoryImage.image = UIImage(data: data)
                }
                break;
                
            case .failure( let  error):
                
                break;
                
                
                
            }
            
            

        }
        
        
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print(catogories[indexPath.row].id)
        let controller = SubCategoryViewController(collectionViewLayout: UICollectionViewFlowLayout())
       //loadingProgress.show(view: self.view)
        controller.category_id = String( catogories[indexPath.row].id )
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
    @objc func loadData()  {
        
        self.loadingProgress.showOnWindow()
        
        Alamofire.request(webURL.catogories,method: .get, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
            
                if response.result.value != nil {
                    
                    self.CustomizeLoadedData(data: response.data!)
                    
                }

         
                
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
            let result = try JSONDecoder().decode(CategoriesModel.self, from: data)
//            let alt = Alerter.make(title:"result",message: result.message);
//            self.present(alt, animated: true, completion: nil)
            
            if result.status == 1 {
                
                    self.catogories = result.categories
                    loadDone()
                
                  //  self.loadingProgress.hideLoadingHub(view: view)
                    
                
            }else{
                
                let alt = Alerter.make(title:"Error",message: result.message);
                self.present(alt, animated: true, completion: nil)
            }
            
            
        }
        catch(let error){
            
            let alt = Alerter.make(title:"result",message: "connection error \(error)");
            self.present(alt, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    
    
    
    
    func loadDone(){
        
        self.refresher.endRefreshing()
        self.loadingProgress.hideLoadingHubFromKeyWindow()
        self.tableView!.refreshControl?.endRefreshing()
        self.tableView?.reloadData()
    }
    
    
    
}

