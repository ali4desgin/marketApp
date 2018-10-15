//
//  ForgetPasswordViewController.swift
//  Store
//
//  Created by MAC on 8/4/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import  Alamofire

class ForgetPasswordViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let vi = UIScrollView()
        vi.alwaysBounceVertical = true
        return vi
    }()
    
    
    
    let loadingProgress = LoadingProgress()
    
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
    
    
    let emailTxt: UITextField = {
        let  sampleTextField =  UITextField()
        sampleTextField.placeholder = "enter your email"
        sampleTextField.font = UIFont.systemFont(ofSize: 14)
        sampleTextField.borderStyle = UITextBorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        //  sampleTextField.isSecureTextEntry = true
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        return sampleTextField
    }()
    
    
    let createTokenButton: UIButton = {
        let btn  = UIButton()
        btn.setTitle("Reset Password", for: .normal)
        btn.setTitleColor(white_color, for: .normal)
        btn.backgroundColor = main_color
        btn.layer.cornerRadius = 5
        //        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()
    
    let cancel: UIButton = {
        let btn  = UIButton()
        btn.setTitle("Cancel & Back", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 5
        //        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        setupViews()
        
    }
    
    
    
    
    func setupViews()  {
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(logoImg)
        scrollView.addSubview(appName)
        scrollView.addSubview(createTokenButton)
        scrollView.addSubview(emailTxt)
        scrollView.addSubview(cancel)
        
        
        scrollView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        logoImg.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 80)
        appName.anchor(logoImg.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        emailTxt.anchor(appName.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 35    )
        createTokenButton.anchor(emailTxt.bottomAnchor, left: emailTxt.leftAnchor, bottom: nil, right: emailTxt.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cancel.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 25, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        
        cancel.addTarget(self, action: #selector(toLogin), for: .touchDown)
        createTokenButton.addTarget(self, action: #selector(createToken), for: .touchDown)
    }
    
    
    @objc func toLogin(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func createToken(){
        loadingProgress.show(view: self.view)
        let parameters: Parameters = [
            "email": emailTxt.text!
        ]
        
        
        
        
        Alamofire.request("http://192.168.0.101/aptanaSudio/Libraries/api/user/forgetpassword",method: .post,parameters: parameters, headers: headers)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                self.loadingProgress.hide()
                switch response.result {
                case .success:
                    self.CustomizeLoadedData(data: response.data!)
                    break;
                case .failure(let error):
                    print(error)
                }
        }
        
        
        
    }
    
    
    private func CustomizeLoadedData(data: Data){
        
        
        do {
            let result = try JSONDecoder().decode(StartUserModel.self, from: data)
            let alt = Alerter.make(title:"result",message: result.message);
            self.present(alt, animated: true, completion: nil)
            
           
            
            
        }
        catch(let error){
            
            let alt = Alerter.make(title:"result",message: "connection error \(error)");
            self.present(alt, animated: true, completion: nil)
        }
        
        
        
    }
    
    
}



