//
//  SideMenViewController.swift
//  StoreApp
//
//  Created by MAC on 8/31/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire

class SideMenViewController: UITableViewController {
    
    
    let cellid = "cellid"
    var balanceTxt:String!
    var profileImage: UIImage!
    var profileTitle:String!
    var profileDescription:String!
    var profileBalance:String!
    var ads_count:String!
    
    let webURL = WebUrls()
    
    
    
    let loadingProgress = LoadingProgress()
    
    var menu_rows = [
        [""],
        ["Edit Profile","Language"],
        ["favorite","My Ads","Chats","Payments History","Add Fund","Notification"],
        ["Tickets","About us","Log Out"]
    ]
    
    
    
    let profiletextLable: UILabel = {
        let label  = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    let balance: UILabel = {
        let label  = UILabel()
        label.numberOfLines = 0
        label.text =  UserDefaults.standard.value(forKey: "balance") as! String + " USD"
        label.textColor = main_color
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    
    let bioLableTxt: UILabel = {
        let label  = UILabel()
        label.numberOfLines = 0
        label.text =  "This document is for iOS developers looking to apply their existing iOS knowledge to build mobile apps with Flutter. If you understand the fundamentals of the iOS framework then you can use this document as a way to get started learning Flutter developme"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let profileimageVie: UIImageView = {
        let imageV = UIImageView()
        imageV.image = #imageLiteral(resourceName: "user")
        imageV.layer.cornerRadius = 40
        imageV.layer.masksToBounds = true
        imageV.layer.borderColor = main_color.cgColor
        imageV.contentMode = .scaleAspectFit
        imageV.layer.borderWidth = 1
        return imageV
    }()
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadData()
        navigationItem.title = "Settings"
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(SideMenCell.self , forCellReuseIdentifier: cellid)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = main_color
        self.navigationController?.navigationBar.prefersLargeTitles = true

      //  self.navigationController?.navigationBar.largeTitleTextAttributes =
     //   navigationItem.largeTitleDisplayMode = .never
        loadUserDefault()
        
       
        
    
//        if L102Language.currentAppleLanguage() == "en" {
//            L102Language.setAppleLAnguageTo(lang: "ar")
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//
//        } else {
//
//            L102Language.setAppleLAnguageTo(lang: "en")
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//
//        }
    }
    
    fileprivate func loadUserDefault(){
        if let username = UserDefaults.standard.value(forKey: "username") {
           profileTitle = username as! String
        }
        
        
        if UserDefaults.standard.value(forKey: "balance") != nil {
           // balanceTxt = String(bln as! Float) as! String
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        loadData()

        print("xxxxxxx")
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return menu_rows.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu_rows[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! SideMenCell
        
        let section = indexPath.section
        let row = indexPath.row
        
        if ( section == 0 && row == 0 )  {
            
           
            
          //  balance.text = balanceTxt + "$"
//            bioLable.text = profileDescription
            profiletextLable.text = profileTitle
            
            
            
            let profileUrl = UserDefaults.standard.value(forKey: "profile_image") as! String
            //self.loadingProgress.showOnWindow()
            
            print(profileUrl)
            Alamofire.request(profileUrl).responseData { response in
                
                switch response.result {
                    
                case .success :
                    if let data = response.data {
                        self.profileimageVie.image  = UIImage(data: data)
                    }
                    self.loadingProgress.hideLoadingHubFromKeyWindow()
                    //  self.tableView.reloadData()
                    break;
                    
                case .failure( let  error):
                    // self.loadingProgress.hideLoadingHubFromKeyWindow()
                    //  self.tableView.reloadData()
                    break;
                    
                    
                    
                }
                
                
                
            }
            
            
            cell.addSubview(profileimageVie)
            cell.addSubview(balance)
            cell.addSubview(profiletextLable)
            cell.addSubview(bioLableTxt)
            
            
            profileimageVie.anchor(cell.topAnchor, left: cell.leftAnchor, bottom: cell.bottomAnchor, right: nil, topConstant: 10, leftConstant: 15, bottomConstant: 10, rightConstant: 5, widthConstant: 80, heightConstant: 80)

            balance.anchor(cell.topAnchor, left: nil, bottom: nil, right: cell.rightAnchor, topConstant: 20, leftConstant: 15, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
//
          profiletextLable.anchor(cell.topAnchor, left: profileimageVie.rightAnchor, bottom: bioLableTxt.topAnchor, right: balance.leftAnchor, topConstant: 20, leftConstant: 15, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
//
//
//
            bioLableTxt.anchor(balance.bottomAnchor, left: profileimageVie.rightAnchor, bottom: cell.bottomAnchor, right: cell.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 5, rightConstant: 20, widthConstant: 0, heightConstant: 0)

            
            
            cell.imageVie.isHidden = true
            cell.textLable.isHidden = true
            
        }else if section == 1 && row == 0 {
            cell.imageVie.image =  #imageLiteral(resourceName: "editprofile").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
            
        }else if section == 1 && row == 1 {
            cell.imageVie.image =  #imageLiteral(resourceName: "language").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
        }else if section == 2 && row == 0 {
            cell.imageVie.image =  #imageLiteral(resourceName: "favorite").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
           // cell.countTxt.text = "(500)"
        }else if section == 2 && row == 1 {
            cell.imageVie.image =  #imageLiteral(resourceName: "myads").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
            cell.countTxt.text = ads_count
            cell.countTxt.textColor = main_color
        }else if section == 2 && row == 2 {
            cell.imageVie.image =  #imageLiteral(resourceName: "latest").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
           // cell.countTxt.text = "(34)"
        }else if section == 2 && row == 3 {
            cell.imageVie.image =  #imageLiteral(resourceName: "paymenthistory").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
        }
        else if section == 2 && row == 4 {
            cell.imageVie.image =  #imageLiteral(resourceName: "addfund").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
        }
        else if  ( section == 2 && row == 5 ) {
            cell.imageVie.image =  #imageLiteral(resourceName: "notifications").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
            //cell.textLable.textColor = red_color
           // cell.countTxt.text = "(40)"
            //cell.countTxt.textColor = red_color
        }
        else if section == 3 && row == 0 {
            cell.imageVie.image =  #imageLiteral(resourceName: "tickets").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
        }else if section == 3 && row == 1 {
            cell.imageVie.image =  #imageLiteral(resourceName: "informations").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
        }else if section == 3 && row == 2 {
            cell.imageVie.image =  #imageLiteral(resourceName: "logout").withRenderingMode(.alwaysTemplate)
            cell.imageVie.tintColor = .gray
            cell.imageVie.isHidden = false
             cell.textLable.isHidden = false
        }
        
        
        
        cell.textLable.text = menu_rows[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if  section == 0  {
            view.isHidden = true
            
        }
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 && row == 0 {
            
            // profile
            let profile = UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
            profile.is_myprofile = true
            profile.user_id = UserDefaults.standard.value(forKey: "id") as! String
            profile.username = (UserDefaults.standard.value(forKey: "username") as? String)!
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.pushViewController(profile, animated: true)
            
        }else if section == 1 && row == 0{
             // edit profile
            
            
            let profile = EditProfileViewController()
//            profile.is_myprofile = true
//            profile.user_id = UserDefaults.standard.value(forKey: "id") as! String
//            profile.username = (UserDefaults.standard.value(forKey: "username") as? String)!
            //self.navigationItem.title = (UserDefaults.standard.value(forKey: "username") as? String)!
            profile.navigationItem.title = (UserDefaults.standard.value(forKey: "username") as? String)!
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.pushViewController(profile, animated: true)
            
        }else if section == 1 && row == 1{
            // language
            
        }else if section == 2 && row == 0{
            
            // favorite
            
            let vc = FavViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if section == 2 && row == 1{
            
            // my ads
        }else if section == 2 && row == 2{
            
            // chats
            let vc = ChatsListViewController()
            //vc.user_id = UserDefaults.standard.value(forKey: "id") as! String
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if section == 2 && row == 3{
            
            // payments history
            
        }
        else if section == 2 && row == 4{
            
            // add fund
            
            let activityVC = AddFundViewController()
//            profile.is_myprofile = true
//            profile.user_id = UserDefaults.standard.value(forKey: "id") as! String
//            profile.username = (UserDefaults.standard.value(forKey: "username") as? String)!
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.pushViewController(activityVC, animated: true)
            
        }
        else if section == 2 && row == 5{
            
            // notifications
            
        }
        else if section == 3 && row == 0{
            
            // tickets
            
        }else if section == 3 && row == 1{
            
            // about us
           
        }else if section == 3 && row == 2 {
            
            //logout
            
            let alert = UIAlertController(title: "Log Out", message: "Are You Sure ?", preferredStyle: UIAlertControllerStyle.actionSheet)
            let logoutActoion = UIAlertAction(title: "Log Out", style: UIAlertActionStyle.default, handler: { (alert) in
                
                UserDefaults.standard.set("", forKey: "id")
                UserDefaults.standard.set("", forKey: "phone")
                UserDefaults.standard.set("", forKey: "gender")
                UserDefaults.standard.set("", forKey: "username")
                UserDefaults.standard.set("", forKey: "bio")
                UserDefaults.standard.set("", forKey: "status")
                UserDefaults.standard.set("", forKey: "profile_image")
                UserDefaults.standard.set("", forKey: "current_location")
                UserDefaults.standard.set("", forKey: "cover_image")
                UserDefaults.standard.set("", forKey: "login_at")
                UserDefaults.standard.set("", forKey: "balance")
                UserDefaults.standard.set("", forKey: "country")
                UserDefaults.standard.set("", forKey: "email")
                UserDefaults.standard.set("", forKey: "linkin_account")
                UserDefaults.standard.set("", forKey: "twitter_account")
                UserDefaults.standard.set("", forKey: "instgaram_account")
                UserDefaults.standard.set("out", forKey: "logged")
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
                
                
            })
            
            let cancel = UIAlertAction(title: "Keep Login", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(logoutActoion)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
            
        }
    
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viw = UIView()
        viw.backgroundColor =  UIColor(white: 0.95, alpha: 1)
        return viw
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 100
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0  {
            return 0
        }
        return 40
    }
    
    
    
     func loadData()  {
        
      
        let user_id = UserDefaults.standard.value(forKey: "id") as! String
        let parameters: Parameters = [
            "user_id" : user_id
        ]
        self.loadingProgress.showOnWindow()
        
        Alamofire.request(webURL.refreshinformation,method: .get, parameters: parameters , headers: headers).responseData { response in
            
            switch response.result {
                
            case .success :
                
                self.customizeRefreshInformation(data:response.data!);
                
               
                break;
                
            case .failure( let  error):
                self.loadingProgress.hideLoadingHubFromKeyWindow()
                self.tableView.reloadData()
                break;
                
                
                
            }
            
            
            
        }
        
        
        
        
        
    }
    
    func customizeRefreshInformation(data:Data)  {
        
        do {
            let result = try JSONDecoder().decode(RefreshInformationModel.self, from: data)
            //            let alt = Alerter.make(title:"result",message: result.message);
            //            self.present(alt, animated: true, completion: nil)
            
            if result.status == 1 {
             
                UserDefaults.standard.set(result.data.balance, forKey: "balance")
                self.balanceTxt = result.data.balance;
                self.ads_count = result.data.csutomer_ads
                self.loadingProgress.hideLoadingHubFromKeyWindow()
                self.tableView.reloadData()
                
                
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
    
    
    
}
