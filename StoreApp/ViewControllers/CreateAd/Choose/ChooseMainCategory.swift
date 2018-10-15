//
//  ChooseMainCategory.swift
//  StoreApp
//
//  Created by MAC on 9/10/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class ChooseMainCategory: UITableViewController {
    
    var shouldDiss = 0
    var Maindelg:NewAdTxtDetailsViewController!
    var catogories = [categoriesForNewAd]()
    let loadingProgress = LoadingProgress()
    let webURL = WebUrls()
    let cellid = "cellid"
    var refresher:UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = so_light_gray
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: cellid)
        setupRefresher()
        
        loadData()
        
        setupNavBar()
    }
    
    func setupNavBar()  {
        
        let nav = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        view.addSubview(nav)
         self.navigationController?.navigationBar.isHidden = false
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        print("view will appear")
        print(shouldDiss)
        if shouldDiss == 1 {
            shouldDiss = 0
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return catogories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catogories[section].subcategories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return catogories[section].title
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = catogories[indexPath.section].subcategories[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChooseLevel()
        vc.delg = self
        vc.Maindelg = Maindelg
        vc.subcategory = catogories[indexPath.section].subcategories[indexPath.row].id
        present(vc, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    
    @objc func loadData()  {
        
        self.loadingProgress.showOnWindow()
        
        print("home")
        Alamofire.request(webURL.categories_with_subcategories,method: .get, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                
                if response.result.value != nil {
                    print(response.result.value)
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
            let result = try JSONDecoder().decode(ChooseCategoriesForNewAdModel.self, from: data)
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
    
    
    func setupRefresher()
    {
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = main_color
        self.refresher.addTarget(self, action: #selector(loadData), for:   .valueChanged)
        self.tableView!.addSubview(refresher)
        
    }
    
    
    
    func loadDone(){
        
        self.refresher.endRefreshing()
        self.loadingProgress.hideLoadingHubFromKeyWindow()
        self.tableView!.refreshControl?.endRefreshing()
        self.tableView?.reloadData()
    }
    
    
    
    
    
}
