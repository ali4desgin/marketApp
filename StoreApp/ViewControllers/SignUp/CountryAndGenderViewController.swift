//
//  CountryAndGenderViewController.swift
//  StoreApp
//
//  Created by MAC on 8/30/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire
import SkyFloatingLabelTextField

class CountryAndGenderViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate {
    
    

    var isKeyboardAppear = false
    let loadingProgress = LoadingProgress()
    let webURL = WebUrls()
    var country = "1"
    var gender = "0"
    var currentlocation:String!
    
    var countries = [countriesModel]()
    let genders = ["Male","Female"]
    
    let countriesPicView : UIPickerView = {
        
        let pic = UIPickerView()
        
        return pic
    }()
    
    
    
    let instgramTxt: SkyFloatingLabelTextField = {
        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.lineHeight = 0.5
        //        text.lineErrorColor = UIColor.red
        //        text.errorMessage = "Username are required field"
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.selectedLineHeight = 0.5
        text.placeholder = "Instgram account @username "
        text.title = "Instagram"
        text.titleFont = UIFont.systemFont(ofSize: 13)
        text.placeholderFont = UIFont.systemFont(ofSize: 13)
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    
    let twitterTxt: SkyFloatingLabelTextField = {
        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.lineHeight = 0.5
        //        text.lineErrorColor = UIColor.red
        //        text.errorMessage = "Username are required field"
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.selectedLineHeight = 0.5
        text.placeholder = "Twitter account @username "
        text.title = "Twitter"
        text.titleFont = UIFont.systemFont(ofSize: 13)
        text.placeholderFont = UIFont.systemFont(ofSize: 13)
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    
    let linkinTxt: SkyFloatingLabelTextField = {
        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.lineHeight = 0.5
        //        text.lineErrorColor = UIColor.red
        //        text.errorMessage = "Username are required field"
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.selectedLineHeight = 0.5
        text.titleFont = UIFont.systemFont(ofSize: 13)
        text.placeholderFont = UIFont.systemFont(ofSize: 13)
        text.placeholder = "Linkin account @username "
        text.title = "Linkin"
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    
    
    let facebookTxt: SkyFloatingLabelTextField = {
        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.lineHeight = 0.5
        //        text.lineErrorColor = UIColor.red
        //        text.errorMessage = "Username are required field"
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.selectedLineHeight = 0.5
        text.titleFont = UIFont.systemFont(ofSize: 13)
        text.placeholderFont = UIFont.systemFont(ofSize: 13)
        text.placeholder = "Fcaebook account @username "
        text.title = "Fcaebook"
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    
    let finshButton: UIButton = {
        let btn  = UIButton()
        btn.setTitle("Finish", for: .normal)
        btn.backgroundColor = main_color
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = white_color
        loadDataForRegisterActivity()
        getMyCurrentLocation()
        setupViews()
        countriesPicView.delegate = self
        countriesPicView.dataSource = self
        self.navigationController?.navigationBar.barTintColor = main_color
        
         


    }
    
    
    func setupViews()  {
        
        view.addSubview(countriesPicView)
        view.addSubview(instgramTxt)
        view.addSubview(facebookTxt)
        view.addSubview(linkinTxt)
        view.addSubview(twitterTxt)
        view.addSubview(finshButton)

        instgramTxt.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: (self.navigationController?.navigationBar.frame.size.height)! + 25, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        facebookTxt.anchor(instgramTxt.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        linkinTxt.anchor(facebookTxt.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        twitterTxt.anchor(linkinTxt.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        countriesPicView.anchor(twitterTxt.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 300)
        
        finshButton.anchor(countriesPicView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 40)
        
        finshButton.addTarget(self, action: #selector(fininshRegister), for: .touchDown)
        
    }
  
    
    
    @objc func fininshRegister(){
        
        let parameters: Parameters = [
            "current_location":currentlocation,
            "user_id": UserDefaults.standard.value(forKey: "id")!,
            "country_id": country,
            "gender": gender,
            "instagram": instgramTxt.text!,
            "facebook": facebookTxt.text!,
            "twitter": twitterTxt.text!,
            "linkin": linkinTxt.text!
            ]
        
        
        
        
        
        
        self.loadingProgress.show(view: view)
        
        Alamofire.request(webURL.finishregister, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                // print(response.data)
                
                self.CustomizeFinish(data: response.data!)
                
                self.loadingProgress.hide()
                break;
                
            case .failure( let  error):
                // self.loadDone()
                print("error in load data \(error)")
                // print(response.data ?? )
                self.loadingProgress.hide()
                break;
                
                
                
            }
        }
        
        
    

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if component == 0 {
            return countries.count
        }
        
        
        return genders.count
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        if component == 0 {
            return 70
        }
        
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return countriesPicView.frame.size.width - 100
        }
        
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 0 {
            let vc = UIView()
            let name = UILabel()
            let currency = UILabel()
            name.text = countries[row].name
            name.numberOfLines = 0
            currency.text = countries[row].currency
            name.font = UIFont.systemFont(ofSize: 14)
            currency.font = UIFont.systemFont(ofSize: 14)
            name.textColor = main_color
            vc.addSubview(name)
            vc.addSubview(currency)
            name.anchor(vc.topAnchor, left: vc.leftAnchor, bottom: nil, right: vc.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
            currency.anchor(name.bottomAnchor, left: vc.leftAnchor, bottom: nil, right: vc.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
            return vc
            
        }
        
        let gender = UILabel()
        gender.text = genders[row]
        gender.font = UIFont.systemFont(ofSize: 14)
        
        return gender
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            country = countries[row].id
        }else{
            
            gender = String(row)
        }
    }
    
    
    func loadDataForRegisterActivity(){
        
        
                //self.loadingProgress.show(view: view)
        
        
                self.loadingProgress.show(view: view)
        
                Alamofire.request(webURL.countries, method: .get, headers: headers).responseJSON { (response) in
                    switch response.result {
        
                    case .success :
                        // print(response.data)
                        self.CustomizeLoadedCountries(data: response.data!)
                        break;
        
                    case .failure( let  error):
                       // self.loadDone()
                        print("error in load data \(error)")
                        // print(response.data ?? )
                        break;
        
        
        
                    }
                }
        
        
        
        
    }
    
    
    
    
    
    func getMyCurrentLocation(){
        
        
        //self.loadingProgress.show(view: view)
        
        
        self.loadingProgress.show(view: view)
        
        Alamofire.request("http://ip-api.com/json", method: .get).responseJSON { (response) in
            switch response.result {
                
            case .success :
                // print(response.data)
                self.CustomizeCurrentLocation(data: response.data!)
                break;
                
            case .failure( let  error):
                // self.loadDone()
                print("error in load data \(error)")
                // print(response.data ?? )
                break;
                
                
                
            }
        }
        
        
        
        
    }
    
    
    func CustomizeCurrentLocation(data:Data)  {
        
        
        do {
            let result = try JSONDecoder().decode(CurrentLocationModel.self, from: data)
            
            
            currentlocation = result.country + " - "  + result.city
            print(currentlocation)
            
            
            
        }
        catch {
            
            let alt = Alerter.make(title:"result",message: "connection error \(error)");
            self.present(alt, animated: true, completion: nil)
        }
        
        
        
    }
    
    func CustomizeFinish(data:Data)  {
        
        do {
            let result = try JSONDecoder().decode(CommonUseModel.self, from: data)
            
            
            
            if result.status == 1 {
               
                UserDefaults.standard.set(currentlocation, forKey: "current_location")
                UserDefaults.standard.set(country, forKey: "country")
                UserDefaults.standard.set(linkinTxt.text!, forKey: "linkin_account")
                UserDefaults.standard.set(twitterTxt.text!, forKey: "twitter_account")
                UserDefaults.standard.set(instgramTxt.text!, forKey: "instgaram_account")
                UserDefaults.standard.set(gender, forKey: "gender")
                UserDefaults.standard.set("logged", forKey: "logged")
                self.present(MainTabBar(), animated: true, completion: nil)
                
                
                
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
    
    
    func CustomizeLoadedCountries(data:Data)  {
        
        
        do {
            let result = try JSONDecoder().decode(RegisterModel.self, from: data)
            
            
            
            if result.status == 1 {
                self.countries = result.countries
                self.countriesPicView.reloadAllComponents()
                self.loadingProgress.hide()
                // self.ads = result.ads
                //                        self.ad = result.ad
                //                        self.customer = result.customer
                //                        self.comments = result.comments
                //
               // print(self.countries)
                //                loadDone()
                
                
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
    
    
    
    
    
}
