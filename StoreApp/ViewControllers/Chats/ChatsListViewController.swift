//
//  ChatsViewController.swift
//  StoreApp
//
//  Created by MAC on 9/1/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class ChatsListViewController: UITableViewController {
    
    let user_id = UserDefaults.standard.value(forKey: "id") as! String
    
    let cellid = "cellid"
    let loadingProgress = LoadingProgress()
    let webURL = WebUrls()
    

    var chatsList = [RoomCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChatRoomCell.self , forCellReuseIdentifier: cellid)
        loadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Chats"
        loadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsList.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ChatRoomCell
       // cell.textLabel?.text = String(indexPath.row)
        cell.with.text = chatsList[indexPath.row].with.username
        
        //cell.setHighlighted(true, animated: true)
        
        if let message =  chatsList[indexPath.row].last_message.message {
            cell.lastmessage.text = message
        }
        
        
        
        if let is_readed = chatsList[indexPath.row].last_message.is_readed {
            if  is_readed == "0" {
                cell.isSelected = true
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func loadData()  {
        
        
        let user_id = UserDefaults.standard.value(forKey: "id") as! String
        let parameters: Parameters = [
            "user_id" : user_id
        ]
        self.loadingProgress.showOnWindow()
        
        Alamofire.request(webURL.chatslist,method: .get, parameters: parameters , headers: headers).responseData { response in
            
            switch response.result {
                
            case .success :
                
                self.customizeChats(data:response.data!);
                
                
                break;
                
            case .failure( let  error):
                self.loadingProgress.hideLoadingHubFromKeyWindow()
                self.tableView.reloadData()
                break;
                
                
                
            }
            
            
            
        }
        
        
        
        
        
    }
    
   fileprivate func customizeChats(data:Data)  {
        
        do {
            let result = try JSONDecoder().decode(ChatsListModel.self, from: data)
            //            let alt = Alerter.make(title:"result",message: result.message);
            //            self.present(alt, animated: true, completion: nil)
            
            if result.status == 1 {
                
                self.chatsList = result.rooms
                
                
                self.loadingProgress.hideLoadingHubFromKeyWindow()
                self.tableView.reloadData()
                
                
                //  self.loadingProgress.hideLoadingHub(view: view)
                
                
            }else{
                self.loadingProgress.hideLoadingHubFromKeyWindow()
                let alt = Alerter.make(title:"Error",message: result.message);
                self.present(alt, animated: true, completion: nil)
            }
            
            
        }
        catch(let error){
            self.loadingProgress.hideLoadingHubFromKeyWindow()
            let alt = Alerter.make(title:"result",message: "connection error \(error)");
            self.present(alt, animated: true, completion: nil)
        }
        
        
    }
    
    
    
}
