//
//  ChooseLevel.swift
//  StoreApp
//
//  Created by MAC on 9/10/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class ChooseLevel: UITableViewController {

    
    let cellid = "cellid"
    var delg:ChooseMainCategory!
    var Maindelg:NewAdTxtDetailsViewController!
    var subcategory = ""
    
    var levels = [LevelCellModelForNew]()
    let loadingProgress = LoadingProgress()
    let webURL = WebUrls()
    var refresher:UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRefresher()
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: cellid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return levels.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = levels[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let vc  = NewAdTxtDetailsViewController()
        Maindelg.level_id = String(levels[indexPath.row].id)
        Maindelg.selected.text = String(levels[indexPath.row].title)
        
        
        self.dismiss(animated: false) {
            self.delg.dismiss(animated: false, completion: nil)
        }
        
        
    }
 

    
    
    @objc func loadData()  {
        
        self.loadingProgress.showOnWindow()
        
        let param: Parameters = ["subcategory_id": subcategory]
        print("home")
        Alamofire.request(webURL.levels,method: .get, parameters: param, headers: headers).responseJSON { (response) in
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
            let result = try JSONDecoder().decode(LevelModelForNewAd.self, from: data)
            //            let alt = Alerter.make(title:"result",message: result.message);
            //            self.present(alt, animated: true, completion: nil)
            
            if result.status == 1 {

                
                print(result)
                self.levels = result.levels
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
            self.dismiss(animated: true, completion: nil)
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
