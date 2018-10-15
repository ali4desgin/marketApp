//
//  FavViewController.swift
//  StoreApp
//
//  Created by MAC on 9/10/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class FavViewController: UITableViewController {

    
    let cellid = "cellid"
    let loadingProgress = LoadingProgress()
    let webUrls = WebUrls()
    let sectionHeader = ["Users","Items"]
    var refresher:UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavTableViewCell.self , forCellReuseIdentifier: cellid)
    }

    override func viewWillAppear(_ animated: Bool) {
        loadingProgress.showOnWindow()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionHeader.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! FavTableViewCell

//        cell.textLabel?.text = String(indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }

    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.insert
    }
   
     //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    func setupRefresher()
    {
        self.refresher = UIRefreshControl()
        self.refresher.tintColor = main_color
        self.refresher.addTarget(self, action: #selector(loadData), for:   .valueChanged)
        self.tableView!.addSubview(refresher)
        
    }
    
    @objc func loadData()  {
        
        self.loadingProgress.showOnWindow()
        let param: Parameters = [
            "user_id": UserDefaults.standard.value(forKey: "id")
        ]
        Alamofire.request(webUrls.fav_list,method: .get, parameters: param, headers: headers).responseJSON { (response) in
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
                
               // self.catogories = result.categories
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
