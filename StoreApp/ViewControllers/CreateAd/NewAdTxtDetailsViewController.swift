//
//  NewAdTxtDetailsViewController.swift
//  StoreApp
//
//  Created by MAC on 9/9/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import  Alamofire
import  TextFieldEffects



class NewAdTxtDetailsViewController: UIViewController, UITextFieldDelegate {
    
    var user_id:String!
    var profileImageData  = UIImageJPEGRepresentation(#imageLiteral(resourceName: "user1"), 0.5)!
    var balanceChecked = false
    let loadingProgress = LoadingProgress()
    let webURL = WebUrls()
    var level_id = ""
    
    
    var TitleTxt:String!
    var DescriptiomTxt:String!
    var priceTxt:String!
    var LevelTxt:String!
    
    
    var topBarHeight:CGFloat = 0.0
    var selectImage:UIImage!
    let adImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 25
        image.layer.masksToBounds = true
        return image
    }()
    
    let Title:KaedeTextField = {
        let text = KaedeTextField()
        text.placeholder = "Title"
        text.foregroundColor = so_light_gray2
        text.font = UIFont.systemFont(ofSize: 15)
//        text.errorColor = UIColor.red
//        text.textColor = UIColor.gray
//        text.lineColor = UIColor(white: 0.85, alpha: 1)
//        text.clearButtonMode = UITextFieldViewMode.whileEditing
//        text.autocorrectionType = UITextAutocorrectionType.no
//        text.keyboardType = UIKeyboardType.default
//        text.returnKeyType = UIReturnKeyType.done
//        text.clearButtonMode = UITextFieldViewMode.whileEditing;
//        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
//        text.lineHeight = 0.5
//        //        text.lineErrorColor = UIColor.red
//        //        text.errorMessage = "Username are required field"
//        text.selectedLineColor = UIColor.gray
//        text.selectedTitleColor = white_color
//        text.selectedLineHeight = 0.5
//        text.font = UIFont.systemFont(ofSize: 13)
//        text.placeholder = "username or email"
//        //text.errorColor = UIColor.redColor
//        text.setTitleVisible(false)
        return text
    }()

    
    let Description:KaedeTextField = {
        let text = KaedeTextField()
        text.font = UIFont.systemFont(ofSize: 15)
        //text.textColor = UIColor(white: 0.85, alpha: 1)
        text.placeholder = "descripton"
        text.foregroundColor = so_light_gray2
        return text
    }()
    
    let DescriptionView:UIView = {
        let text = UIView()
        return text
    }()
    
    let Price:KaedeTextField = {
        let text = KaedeTextField()
        text.foregroundColor = so_light_gray2
//        text.errorColor = UIColor.red
//        text.textColor = UIColor.gray
//        text.lineColor = UIColor(white: 0.85, alpha: 1)
//        text.clearButtonMode = UITextFieldViewMode.whileEditing
//        text.autocorrectionType = UITextAutocorrectionType.no
//        text.keyboardType = UIKeyboardType.numberPad
//        text.returnKeyType = UIReturnKeyType.done
//        text.clearButtonMode = UITextFieldViewMode.whileEditing;
//        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
//        text.lineHeight = 0.5
//        //        text.lineErrorColor = UIColor.red
//        //        text.errorMessage = "Username are required field"
//        text.selectedLineColor = UIColor.gray
//        text.selectedTitleColor = white_color
//        text.selectedLineHeight = 0.5
        text.font = UIFont.systemFont(ofSize: 15)
        text.placeholder = "Price"
        
        //text.errorColor = UIColor.redColor
       // text.setTitleVisible(false)
        return text
    }()
    
    let sepView1v:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return vi
    }()
    let sepView2v:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor(white: 0.90, alpha: 1)
        return vi
    }()
    
    let selected:UILabel = {
        let label = UILabel()
        label.text = "Choose!"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let levelSelector:UIView = {
        let vi = UIView()
//        vi.backgroundColor = UIColor.blue
        return vi
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        profileImageData = UIImageJPEGRepresentation(selectImage, 0.1)!
        user_id = UserDefaults.standard.value(forKey: "id") as! String
        // Do any additional setup after loading the view.
         topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        self.navigationController?.navigationBar.barTintColor = main_color
        adImage.image = selectImage
        setupViews()
        setupNavBar()
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    fileprivate func setupNavBar() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target: self, action: #selector(saveItem))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("The Level id" + level_id)
    }
    
    
    fileprivate func setupViews(){
        
         view.addSubview(Title)
        view.addSubview(DescriptionView)
         DescriptionView.addSubview(Description)
         DescriptionView.addSubview(adImage)
        view.addSubview(sepView1v)
        view.addSubview(Price)
        view.addSubview(levelSelector)
        view.addSubview(sepView2v)
        
        setupLevelView()
        Description.backgroundColor = UIColor.clear
       // Description.backgroundColor = .red
        Title.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: topBarHeight , leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        DescriptionView.anchor(Title.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 70)
        adImage.anchor(DescriptionView.topAnchor, left: nil, bottom: nil, right: DescriptionView.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant:5, widthConstant: 50, heightConstant: 50)
        Description.anchor(DescriptionView.topAnchor, left: DescriptionView.leftAnchor, bottom: DescriptionView.bottomAnchor, right: adImage.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
    
        sepView1v.anchor(Description.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        Price.anchor(sepView1v.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        levelSelector.anchor(Price.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        sepView2v.anchor(levelSelector.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
    
    fileprivate func setupLevelView(){
        let title:UILabel = {
           let label = UILabel()
            label.text = "Category"
            label.textColor = UIColor.gray
            label.font = UIFont.systemFont(ofSize: 13)
            return label
        }()
        
        
        
        let arrow:UIImageView = {
            let label = UIImageView()
        //    label.image = #imageLiteral(resourceName: "rightarrow").withRenderingMode(.alwaysTemplate)
            label.tintColor = UIColor(white: 0.90, alpha: 1)
            return label
        }()
        
        levelSelector.addSubview(title)
        levelSelector.addSubview(selected)
        levelSelector.addSubview(arrow)
        
        title.anchor(levelSelector.topAnchor, left: levelSelector.leftAnchor, bottom: levelSelector.bottomAnchor, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        arrow.anchor(levelSelector.topAnchor, left: nil, bottom: nil, right: levelSelector.rightAnchor, topConstant: 10, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 30)
        
        selected.anchor(levelSelector.topAnchor, left: nil, bottom: levelSelector.bottomAnchor, right: arrow.leftAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        
        
        let tabgesRe = UITapGestureRecognizer(target: self, action: #selector(chooseLevel))
        tabgesRe.numberOfTapsRequired = 1
        levelSelector.addGestureRecognizer(tabgesRe)
        
    }

    
    
    
    @objc func chooseLevel(){
       let vc = ChooseMainCategory()
        vc.Maindelg = self
        present(vc, animated: true, completion: nil)
        
        
    }
    
  
     @objc func saveItem(){
        
         TitleTxt = Title.text!
         DescriptiomTxt = Description.text!
         priceTxt = Price.text!
         LevelTxt =  level_id
        
        
        if TitleTxt.isEmpty {
            let alt = Alerter.make(title:"Error",message: "Title Can't be empty");
            self.present(alt, animated: true, completion: nil)
        } else  if priceTxt.isEmpty {
            let alt = Alerter.make(title:"Error",message: "Price Can't be empty");
            self.present(alt, animated: true, completion: nil)
            
        } else if DescriptiomTxt.isEmpty {
            let alt = Alerter.make(title:"Error",message: "Description Can't be empty");
            self.present(alt, animated: true, completion: nil)
        }else if  LevelTxt.isEmpty {
            
            let alt = Alerter.make(title:"Error",message: "Please Choose Category");
            self.present(alt, animated: true, completion: nil)
            
        } else{
            checkUserBalance()
            
//          /  print(balanceChecked)
//            if balanceChecked {
//
//                self.loadingProgress.hideLoadingHubFromKeyWindow()
//            }
            
            
            
            
        }
        
        
    }
    
    
    
    fileprivate func SaveItemWeb(title:String,description:String,price:String,level_id:String){
        
                let parameters:Parameters = [
                        "title": title,
                        "description": description,
                        "price": price,
                        "level_id": level_id,
                        "user_id": user_id
                    ]
        
           // profileImageData = UIImageJPEGRepresentation(selectImage, 0.1)!
                print("parameters = \(parameters)")
        
                if let imageData = selectImage.jpeg(.lowest) {
                    //print(imageData.count)
                    profileImageData = imageData
                    // cell.adsImage.image = UIImage(data: imageData)
                }
        
        
        
            let URL = try! URLRequest(url: webURL.publishadd, method: .post , headers: headers)
        
                Alamofire.upload(multipartFormData: { (multipartFormData) in
                    print("alamofire upload")
        
                    
                    multipartFormData.append(self.profileImageData, withName: "profile_image", fileName: "profile_image.jpg", mimeType: "image/jpg")
        
        
                    for (key, value) in parameters {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                }, with: URL, encodingCompletion: { (result) in
        
                    print("result = \(result)")
                    switch result {
                    case .success(let upload, _, _):
        
                        upload.uploadProgress(closure: { (Progress) in
                            print("Upload Progress: \(Progress.fractionCompleted)")
                        })
        
                        upload.responseJSON { response in
        
                            do {
                            
                                let json = try JSONDecoder().decode(NewAdModel.self, from: response.data!)
                                
                                self.loadingProgress.hideLoadingHubFromKeyWindow()
                                
//                                print(response.description)
                                if json.status == 1{
                                    UserDefaults.standard.set(json.balance, forKey: "balance")
                                    let alert = UIAlertController(title: "Success", message: "Your Ads Will Appear Now", preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alert) in
                                        
                                        let vc  = UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout());
                                        vc.is_myprofile = true
                                        vc.user_id = UserDefaults.standard.value(forKey: "id") as! String
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    })
                                    alert.addAction(ok)
                                    //  let alt = Alerter.make(title:"Balance",message: json.message);
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    
                                }else{
                                    let alt = Alerter.make(title:"Error",message: json.message);
                                    self.present(alt, animated: true, completion: nil)
                                }
                                
                            }catch(let error){
                                self.loadingProgress.hideLoadingHubFromKeyWindow()
                                let alt = Alerter.make(title:"Error",message: error.localizedDescription);
                                self.present(alt, animated: true, completion: nil)
                            }
                           // self.CustomizeLoadedData(data:response.data!)
                          //  self.loadingProgress.hide()
                        }
        
                        upload.responseString { response in
                            debugPrint("SUCCESS RESPONSE: \(response)")
                            self.loadingProgress.hide()
                        }
        
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                })
        
        
        
        
        
        
        
    }
    
  
    
    
   fileprivate func checkUserBalance(){
        
        //
        //        //self.loadingProgress.show(view: view)
        //
        //
            self.loadingProgress.showOnWindow()
    
            let parms : Parameters = ["user_id": user_id! ]
            Alamofire.request(webURL.checkBalance, method: .get,parameters: parms, headers: headers).responseJSON { (response) in
                switch response.result {
    
                case .success :
                    print(response.description)
                    
                    do {
                        
                        var json = try JSONDecoder().decode(CheckUserBalanceModel.self , from: response.data!)
                        if  json.status == 1 {
                           
                            let balance = Int(json.balance)
                            if  balance! <= 0 {
                                self.loadingProgress.hideLoadingHubFromKeyWindow()
                                self.balanceChecked = false
                                let alert = UIAlertController(title: "Balance", message: "You Doesn't have Balance", preferredStyle: UIAlertControllerStyle.alert)
                                let addbalance = UIAlertAction(title: "Add Balance", style: UIAlertActionStyle.default, handler: { (alert) in
                                    self.navigationController?.pushViewController(AddFundViewController(), animated: true)
                                })
                                let later = UIAlertAction(title: "later", style: UIAlertActionStyle.cancel, handler: nil)
                                alert.addAction(later)
                                alert.addAction(addbalance)
                              //  let alt = Alerter.make(title:"Balance",message: json.message);
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                
                                print("Balance checked")
                                self.SaveItemWeb(title:self.TitleTxt,description:self.DescriptiomTxt,price:self.priceTxt,level_id:self.LevelTxt);

                               // self.balanceChecked = true
                            }
                        }else{
                            self.balanceChecked = false
                            
                            self.loadingProgress.hideLoadingHubFromKeyWindow()
                            
                            let alt = Alerter.make(title:"Error",message: json.message);
                            self.present(alt, animated: true, completion: nil)
                        }
                    }catch{
                        self.balanceChecked = false
                    }
                    break;
    
                case .failure( let  error):
                   // self.loadDone()
                    print("error in load data \(error)")
                    // print(response.data ?? )
                    break;
    
    
    
                }
            }
        
        
        
        
    }
    
//
//    func CustomizeLoadedCountries(data:Data)  {
//
//
//        do {
//            let result = try JSONDecoder().decode(RegisterModel.self, from: data)
//
//
//
//            if result.status == 1 {
//                self.countries = result.countries
//                self.countriesPicView.reloadAllComponents()
//                // self.ads = result.ads
//                //                        self.ad = result.ad
//                //                        self.customer = result.customer
//                //                        self.comments = result.comments
//                //
//                print(result)
//                //                loadDone()
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
//
//
    
    }
    


