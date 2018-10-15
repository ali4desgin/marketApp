//
//  LoginViewController.swift
//  Store App
//
//  Created by Ali abdalla on 8/4/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire
import UserNotifications
import  AccountKit


class LoginViewController: UIViewController, UIScrollViewDelegate , AKFViewControllerDelegate {
    
  
    fileprivate var _accountKit = AKFAccountKit(responseType: .accessToken)
    fileprivate var pendingLoginViewController: AKFViewController? = nil
    fileprivate var showAccountOnAppear = false
    fileprivate let app = UIApplication.shared.delegate as! AppDelegate
    var facebookAccountID:String!
    var PhoneNumber:String!
    
//    var _accountKit:AKFAccountKit!
    
    let loadingProgress = LoadingProgress()
    
    let webURL = WebUrls()
    
    let scrollView: UIScrollView = {
       let vi = UIScrollView()
        vi.alwaysBounceVertical = true
        vi.scrollsToTop = true
        return vi
    }()
    
    let logoImg : UIImageView = {
       let img = UIImageView()
        img.image = #imageLiteral(resourceName: "logo")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let appName: UILabel = {
       let lbl = UILabel()
        lbl.text = "MyStore"
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        lbl.textColor = main_color
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    
    
    
    
    
    let startButton: UIButton = {
       let btn  = UIButton()
        btn.setTitle("Let's Start", for: .normal)
        btn.backgroundColor = main_color
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        //checkLogin()
        if showAccountOnAppear {
            showAccountOnAppear = false
//            presentWithSegueIdentifier("showAccount", animated: animated)
        } else if let viewController = pendingLoginViewController {
            prepareLoginViewController(viewController)
            if let viewController = viewController as? UIViewController {
                present(viewController, animated: animated, completion: nil)
                pendingLoginViewController = nil
            }
        }
        
    }
    
    
    

    func prepareLoginViewController(_ loginViewController: AKFViewController) {
            loginViewController.delegate = self
            loginViewController.enableSendToFacebook = true;
            loginViewController.enableGetACall = true;
            loginViewController.setTheme(AKFTheme.default())
    }

    
    
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        
        _accountKit.requestAccount { [weak self] (account, error) in
            if error != nil {
               
            } else {
               // self?.accountIDLabel.text = account?.accountID
                
                
                if let emailAddress = account?.emailAddress
                    , emailAddress.count > 0 {
                   // self?.titleLabel.text = "Email Address"
                   // self?.valueLabel.text = emailAddress
                } else if let phoneNumber = account?.phoneNumber {
                    self?.facebookAccountID = account?.accountID
                    self?.PhoneNumber = phoneNumber.stringRepresentation()
        
                    self?.StartUserWeb()
               
                   // self?.titleLabel.text = "Phone Number"
                 //   self?.valueLabel.text = phoneNumber.stringRepresentation()
                }
            }
        }
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        showAccountOnAppear = _accountKit.currentAccessToken != nil
        pendingLoginViewController = _accountKit.viewControllerForLoginResume()

        
//        _accountKit = AKFAccountKit.init(responseType: .accessToken)
        
        
        
        
//        let app = UIApplication.shared.delegate as! AppDelegate
//        print(app.userdeviceToken)
////        let content = UNMutableNotificationContent()
////        content.title = "Welcome To Bay3"
////        content.body = "We Are Happy To Become One Of Our Community"
////        content.sound = UNNotificationSound.default()
////
////        let trrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
////
////        let request = UNNotificationRequest(identifier: "noi_id", content: content, trigger: trrigger)
////
////        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
////
        checkLogin()
        
       
        
        print(self.view.frame.size.height)
        self.view.frame.size.height = 1000.0
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        setupTargets()
        setupViews()
       
    }
    
    
    
    
    
    
    
  
    
    
    
    
    
    
    private func checkLogin()  {
        UserDefaults.standard.set("logged", forKey: "logged")
        print(UserDefaults.standard.value(forKey: "logged")!)
        if let looged = UserDefaults.standard.value(forKey: "logged")  {
            print(looged)
            if looged as! String == "logged" {
                let phone = UserDefaults.standard.value(forKey: "phone")
                
                
                
                self.present(MainTabBar(), animated: true, completion: nil)
            }

        }

        
       
    
    
        
        
        
        
    }
    
    
    
    
    
    
    
    func setupViews()  {
        view.addSubview(scrollView)
        
        
        scrollView.addSubview(logoImg)
        scrollView.addSubview(appName)
        scrollView.addSubview(startButton)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
      
       [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
     
        ].forEach({$0.isActive = true})
        
        
        logoImg.anchor(scrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 80)
        appName.anchor(logoImg.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        startButton.anchor(appName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 12, bottomConstant: 25, rightConstant: 12, widthConstant: 0, heightConstant: 45)
        
    }
    
    
    
    
   
    

    
    func setupTargets(){
     
        
        startButton.addTarget(self, action: #selector(StartFunction), for: .touchDown)

    }
    
 
    

    
    
    
    
    
    
    
    @objc func StartFunction(){

        if let viewController = _accountKit.viewControllerForPhoneLogin(with: nil, state: nil) as? AKFViewController {
            prepareLoginViewController(viewController)
            if let viewController = viewController as? UIViewController {
                present(viewController, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func StartUserWeb(){
        self.view.endEditing(true)

        
        
        self.loadingProgress.showOnWindow()
        let parameters: Parameters = [
            "phone": PhoneNumber,
            "token": app.userdeviceToken,
            "fid": facebookAccountID
        ]




        Alamofire.request(webURL.startuser,method: .post,parameters: parameters, headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                                switch response.result {
                case .success:
                    self.loadingProgress.hideLoadingHubFromKeyWindow()
                    print("request response\(response.description)")
                    self.CustomizeLoadedData(data: response.data!)
                    break;
                case .failure(let error):
                    self.loadingProgress.hideLoadingHubFromKeyWindow()
                    print(error)
                }



        }


        
    }
    
    
    func CustomizeLoadedData(data: Data)  {
        
        
        do {
            let result = try JSONDecoder().decode(StartUserModel.self, from: data)
            
            //print(result.message)
            if result.status == 0 {
                
                let alt = Alerter.make(title:"Error",message: result.message);
                self.present(alt, animated: true, completion: nil)
                
            }else{
               
                
                
                
                if result.old_register == "1" {
                    
                    
                    if result.user.profile_status == "1" {
                        
                        UserDefaults.standard.set(result.user.id, forKey: "id")
                        UserDefaults.standard.set(PhoneNumber, forKey: "phone")
                        UserDefaults.standard.set(result.user.gender, forKey: "gender")
                        UserDefaults.standard.set(result.user.username, forKey: "username")
                        UserDefaults.standard.set(result.user.bio, forKey: "bio")
                        UserDefaults.standard.set(result.user.status, forKey: "status")
                        UserDefaults.standard.set(result.user.profile_image, forKey: "profile_image")
                        UserDefaults.standard.set(result.user.current_location, forKey: "current_location")
                        UserDefaults.standard.set(result.user.cover_image, forKey: "cover_image")
                        UserDefaults.standard.set(result.user.login_at, forKey: "login_at")
                        UserDefaults.standard.set(result.user.balance, forKey: "balance")
                        UserDefaults.standard.set(result.user.country, forKey: "country")
                        UserDefaults.standard.set(result.user.email, forKey: "email")
                        UserDefaults.standard.set(result.user.linkin_account, forKey: "linkin_account")
                        UserDefaults.standard.set(result.user.twitter_account, forKey: "twitter_account")
                        UserDefaults.standard.set(result.user.instgaram_account, forKey: "instgaram_account")
                        UserDefaults.standard.set("logged", forKey: "logged")
                       // self.navigationController?.pushViewController(MainTabBar(), animated: true)
                        toRegisterCompition()
                    }else{
                        UserDefaults.standard.set(PhoneNumber, forKey: "phone")
                        UserDefaults.standard.set(result.user.id, forKey: "id")
                        //self.navigationController?.pushViewController(RegisterViewController(), animated: true)
                         toRegisterCompition()
                    }
                    
                    
                }else{
                    
                    UserDefaults.standard.set(PhoneNumber, forKey: "phone")
                    UserDefaults.standard.set(result.id, forKey: "id")
                    //self.navigationController?.pushViewController(RegisterViewController(), animated: true)
                    toRegisterCompition()
                    
                }
                
                
                
                self.present(MainTabBar(), animated: true, completion: nil)
                
                
            }
            
        }
        catch(let error){
            
            print(error)
        }
    }
    
    
    fileprivate func toRegisterCompition(){
        let controller = RegisterViewController()
        // loadingProgress.show(view: self.view)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        controller.tabbarheight = self.navigationController?.navigationBar.frame.size.height
        //  controller.ta = self.navigationController?.navigationBar.frame.size.height
        self.navigationController?.navigationBar.barTintColor = main_color
        self.navigationController?.navigationBar.tintColor = white_color
        controller.navigationItem.title = "Register"
        self.tabBarController?.tabBar.tintColor = white_color
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    

    
}
