//
//  RegisterViewController.swift
//  StoreApp
//
//  Created by MAC on 8/29/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire
import SkyFloatingLabelTextField
import AssetsLibrary
import PhotosUI

class RegisterViewController: UIViewController , UIPickerViewDelegate ,UIPickerViewDataSource,UITextFieldDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    var tabbarheight:CGFloat!
    var imagePicker = UIImagePickerController()
    var checkImg = true
    
    var profileImageData  = UIImageJPEGRepresentation(#imageLiteral(resourceName: "user1"), 0.5)!
    
    var profileImageName = ""
    
    
    let imageProfile : UIButton = {
       let image = UIButton()
        image.setImage(#imageLiteral(resourceName: "cameraplus").withRenderingMode(.alwaysTemplate), for: .normal)
        image.tintColor = .gray
        image.layer.cornerRadius = 45
        image.layer.masksToBounds = true
//        image.layer.borderColor = UIColor.gray.cgColor
//        image.layer.borderWidth = 0.5
        image.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        return image
    }()
    
    let imageProfileCover : UIView = {
        let image = UIView()
        return image
    }()
    
    let loginButton: UIButton = {
        let btn  = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = main_color
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    
    let pageTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Register New Account"
        return label
    }()
    
    let usernameTxt: SkyFloatingLabelTextField = {
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
        text.placeholder = "Username"
        text.title = "Username"
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    let phoneTxt: SkyFloatingLabelTextField = {
        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.numberPad
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.lineHeight = 0.5
        //        text.lineErrorColor = UIColor.red
        //        text.errorMessage = "Username are required field"
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.selectedLineHeight = 0.5
        text.placeholder = "Phone"
        text.title = "Phone"
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    let emailTxt: SkyFloatingLabelTextField = {
        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        
        text.lineHeight = 0.5
        //        text.lineErrorColor = UIColor.red
        //        text.errorMessage = "Username are required field"
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.selectedLineHeight = 0.5
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.emailAddress
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.placeholder = "Email"
        text.title = "Email"
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    let passwordTxt: SkyFloatingLabelTextField = {
        let text = SkyFloatingLabelTextField()
        text.errorColor = UIColor.red
        text.textColor = UIColor.lightGray
        text.lineColor = UIColor.lightGray
        text.lineHeight = 0.5
        //        text.lineErrorColor = UIColor.red
        //        text.errorMessage = "Username are required field"
        text.selectedLineColor = UIColor.gray
        text.selectedTitleColor = main_color
        text.isSecureTextEntry = true
        text.selectedLineHeight = 0.5
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextFieldViewMode.whileEditing;
        text.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        text.placeholder = "Password"
        text.title = "Password"
        //text.errorColor = UIColor.redColor
        return text
    }()
    
    
   let loadingProgress = LoadingProgress()
   let webURL = WebUrls()
    
    
    var countries = [countriesModel]()
    
    
    let countriesPicView : UIPickerView = {
       
        let pic = UIPickerView()
       
        return pic
    }()
    
    
    
    
    let containerView : UIScrollView = {
       let vc = UIScrollView()
        vc.alwaysBounceVertical = true
        vc.isScrollEnabled = true
        vc.alwaysBounceHorizontal = false
        vc.backgroundColor = white_color
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = white_color
        
    
        
        //preferredStatusBarStyle = UIStatusBarStyle.lightContent
        self.setNeedsStatusBarAppearanceUpdate()
        loadDataForRegisterActivity()
        setupViews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }

    

    
    func setupViews( )  {
        setupSubViews()
        
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        
        containerView.addGestureRecognizer(mytapGestureRecognizer)
       // loginButton.addGestureRecognizer(mytapGestureRecognizer)
        countriesPicView.delegate = self
        countriesPicView.dataSource = self
        
        
       //containerView.backgroundColor = .red
         view.addSubview(containerView)
        containerView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: tabbarheight, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        
        
     //   countriesPicView.selectedRow(inComponent: 12)
        
        
        
    }
    
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    func setupProfileImage()  {
        
        let size = view.frame.size.width
        print(size)
        imageProfileCover.addSubview(imageProfile)
        imageProfile.anchor(imageProfileCover.topAnchor, left: imageProfileCover.leftAnchor, bottom: imageProfileCover.bottomAnchor, right: imageProfileCover.rightAnchor, topConstant: 5, leftConstant: (size / 2 ) - 65, bottomConstant: 0, rightConstant: (size / 2 ) - 65, widthConstant: 90, heightConstant: 90)
        //imageProfile.frame = CGRect(x: (size / 2 ) - 60 , y: 0, width: 80, height: 80)
        
        
//        let imageCaputre = UITapGestureRecognizer(target: self, action: #selector(captureImage))
//        imageCaputre.numberOfTapsRequired = 1
//        imageProfile.addGestureRecognizer(imageCaputre)
        imageProfile.addTarget(self, action: #selector(captureImage), for: .touchDown)
    }
    
    
    
    @objc func captureImage() {
        
        showImagePicker()
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            let myPickerController = UIImagePickerController()
//            myPickerController.delegate = self
//            myPickerController.sourceType = .camera
//            self.present(myPickerController, animated: true, completion: nil)
//        }
    }
    
    
    
    
    func showImagePicker(){
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            actionSheet.addAction(UIAlertAction(title: "take photo", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.camera()
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "choose photo", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.photoLibrary()
                
            }))
            
            
        } else {
            
            actionSheet.addAction(UIAlertAction(title: "upload photo", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
                
                self.photoLibrary()
                
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func camera(){
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func photoLibrary() {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        print("done upload image ")
        
        
            if let imageData = image.jpeg(.lowest) {
                //print(imageData.count)
                profileImageData = imageData
               // cell.adsImage.image = UIImage(data: imageData)
            }
       
        
        
        
        
        self.imageProfile.setImage(image, for: .normal)
        
        self.imageProfile.imageView?.contentMode = .scaleToFill
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
       // print("Diss")
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    func setupSubViews()  {
        
        
        setupProfileImage()
        let allWidth = self.view.frame.size.width - 40;
       // containerView.addSubview(countriesPicView)
        containerView.addSubview(imageProfileCover)
        containerView.addSubview(pageTitle)
        containerView.addSubview(usernameTxt)
        containerView.addSubview(phoneTxt)
        containerView.addSubview(emailTxt)
        containerView.addSubview(passwordTxt)
        containerView.addSubview(loginButton)
        
        imageProfileCover.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant:     0, heightConstant: 0)
        
        pageTitle.anchor(imageProfileCover.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant:     allWidth, heightConstant: 40)
        usernameTxt.anchor(pageTitle.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant:     allWidth, heightConstant: 50)
        emailTxt.anchor(usernameTxt.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant:     allWidth, heightConstant: 50)
        
        phoneTxt.anchor(emailTxt.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant:     allWidth, heightConstant: 50)
       
        
        passwordTxt.anchor(phoneTxt.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant:     allWidth, heightConstant: 50)
        
      //  countriesPicView.anchor(passwordTxt.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: allWidth, heightConstant: 250)
        
        loginButton.anchor(passwordTxt.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 50)
        
        
        
        
        loginButton.addTarget(self, action: #selector(registerWeb), for: .touchDown)
       // countriesPicView.selectRow(30, inComponent: 1, animated: true)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.containerView.endEditing(true)
        
       
    }
   
    
    
    
    
    @objc func registerWeb(){
        
        
        
      loadingProgress.show(view: self.view)
        let parameters: [String:String] = [
            "username": usernameTxt.text!,
            "password": passwordTxt.text!,
            "email": emailTxt.text!,
            "phone": phoneTxt.text!,
            "gender": "1"
        ]
        

        
      
        
        
        print("parameters = \(parameters)")
        
        let URL = try! URLRequest(url: webURL.register, method: .post, headers: headers)
        
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
                    
                    self.CustomizeLoadedData(data:response.data!)
                    self.loadingProgress.hide()
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
    
    
    
    
    func CustomizeLoadedData(data:Data)  {
        
        do {
            let result = try JSONDecoder().decode(StartUserModel.self, from: data)
            
            print(result.message)
            if result.status == 0 {
                
                let alt = Alerter.make(title:"Error",message: result.message);
                self.present(alt, animated: true, completion: nil)
                
            }else{
       
                
                UserDefaults.standard.set(result.user.id, forKey: "id")
                UserDefaults.standard.set(result.user.phone, forKey: "phone")
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
                UserDefaults.standard.set(result.user.gender, forKey: "gender")
                UserDefaults.standard.set("countryandgender", forKey: "logged")

                
                self.present(UINavigationController(rootViewController: CountryAndGenderViewController()), animated: true, completion: nil)
                
                
            }
            
        }
        catch(let error){
            
            print(error)
        }
        
    }
    
    
    
    
    
    
    func loadDataForRegisterActivity(){
        
//
//        //self.loadingProgress.show(view: view)
//
//
//        self.loadingProgress.show(view: view)
//
//        Alamofire.request(webURL.countries, method: .get, headers: headers).responseJSON { (response) in
//            switch response.result {
//
//            case .success :
//                 //print(response.data)
//                self.CustomizeLoadedCountries(data: response.data!)
//                break;
//
//            case .failure( let  error):
//               // self.loadDone()
//                print("error in load data \(error)")
//                // print(response.data ?? )
//                break;
//
//
//
//            }
//        }
//
        
        
        
    }
    
    
    func CustomizeLoadedCountries(data:Data)  {
        
       
                do {
                    let result = try JSONDecoder().decode(RegisterModel.self, from: data)
        
        
        
                    if result.status == 1 {
                        self.countries = result.countries
                        self.countriesPicView.reloadAllComponents()
                        // self.ads = result.ads
//                        self.ad = result.ad
//                        self.customer = result.customer
//                        self.comments = result.comments
//
                        print(result)
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
