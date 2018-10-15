//
//  ItemDetailsHeaderCell.swift
//  Store
//
//  Created by MAC on 8/3/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire

class ItemDetailsHeaderCell: UICollectionViewCell {
   
    
    
    
    
    let loadingProgress = LoadingProgress()
    var refresher:UIRefreshControl!
    let webURL = WebUrls()
    
    var del : ItemDetailsViewController?
    
    var customer_phone: String = "01130141615"
    var customer_id: String!
    var username:String!
    var ad_id: String!

    // upper view
    let upperTab: UIView = {
       let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    
    
    
    let profileImage : UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "user")
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        return image
    }()
    
    let usernameLbl : UIButton = {
        let lbl = UIButton()
        lbl.setTitle("Ali Abdalla Mansour", for: [])
        lbl.titleLabel?.font = UIFont(name: "Thonburi", size: UIFont.systemFontSize)!
       // lbl.textColor = main_color
        lbl.setTitleColor(main_color, for: [])
        lbl.titleLabel?.textAlignment = .left
        return lbl
    }()
    
    
    
    let optionsMenu : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "comments")
        return img
    }()
    
    let seprator : UIView = {
        let lbl = UIView()
        lbl.backgroundColor = .gray
        return lbl
    }()
    
    
    //images
    
    let adImage : UIImageView = {
        let image = UIImageView()
        //image.image = #imageLiteral(resourceName: "keyboard")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
//        image.layer.cornerRadius = 20
//        image.layer.masksToBounds = true
        return image
    }()
    
    
    
    // activities
    let activityTab: UIView = {
        let v = UIView()
        v.backgroundColor =  UIColor(white: 0.95, alpha: 1)
      //  v.backgroundColor = .blue
        return v
    }()
    
    
    let stepsTextField : UITextField = {
        let Fieldframe = UITextField()
        Fieldframe.placeholder = "Enter text here"
        Fieldframe.font = UIFont.systemFont(ofSize: 15)
        Fieldframe.borderStyle = UITextBorderStyle.roundedRect
        Fieldframe.autocorrectionType = UITextAutocorrectionType.no
        Fieldframe.keyboardType = UIKeyboardType.default
        Fieldframe.returnKeyType = UIReturnKeyType.done
        Fieldframe.clearButtonMode = UITextFieldViewMode.whileEditing;
        Fieldframe.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        return Fieldframe
    }()
    
    let addComment : UIButton = {
        let lbl = UIButton()
        lbl.setTitle("Comment", for: [])
        lbl.backgroundColor = main_color
        lbl.layer.cornerRadius = 3
        lbl.layer.masksToBounds = true
        lbl.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        // lbl.textColor = main_color
        lbl.setTitleColor(.white, for: [])
        lbl.titleLabel?.textAlignment = .left
        return lbl
    }()
    
    
    
    
    
    /// contact view
    let ContactView:  UIView = {
       let v = UIView()
        v.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return v
    }()
    
    
    // contacts emlements
    let likeImage : UIButton = {
       
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysTemplate), for: [])
        btn.tintColor = main_color
        return btn
    }()

    let messageImage : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "chat").withRenderingMode(.alwaysTemplate), for: [])
        btn.tintColor = main_color
        return btn
    }()

    let callImage : UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "call").withRenderingMode(.alwaysTemplate), for: [])
        btn.tintColor = main_color
        return btn
    }()
    
    
    
//
//    let viewsImage : UIImageView = {
//        let image = UIImageView()
//        image.image = #imageLiteral(resourceName: "eye").withRenderingMode(.alwaysTemplate)
//        image.contentMode = .scaleAspectFit
//        return image
//    }()
//    let viewsCount : UILabel = {
//        let label = UILabel()
//        label.text = "30835,934"
//
//        label.font = UIFont.systemFont(ofSize: 13)
//        label.textColor = UIColor.gray
//        return label
//    }()
//
    
    
    let adsPrice: UILabel = {
        let label = UILabel()
        let sequence = 0 ..< 7
        let shuffledSequence = arc4random() / 200000
        label.textColor = main_color
        label.text = "\(shuffledSequence)$" as String
        //label.textColor = white_color
        //label.backgroundColor = main_color
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
//        self.window?.rootViewController?.navigationController?.pushViewController(LoginViewController(), animated: true)
        
        
        
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    
    func setupViews()  {
        
            setupUpperTab()
            setupActivityTab()
            setContactTab()
            addSubview(upperTab)
            addSubview(adImage)
            addSubview(ContactView)
            addSubview(activityTab)
        
            upperTab.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
//            adImage.anchor(upperTab.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 270)
//        
//        
            ContactView.anchor(adImage.bottomAnchor, left: leftAnchor, bottom: activityTab.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
            activityTab.anchor(ContactView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        
        
    }
    
    
    func setupUpperTab()  {
        
            upperTab.addSubview(profileImage)
            upperTab.addSubview(usernameLbl)
            upperTab.addSubview(optionsMenu)
            upperTab.addSubview(seprator)
        
            profileImage.anchor(upperTab.topAnchor, left: upperTab.leftAnchor, bottom: upperTab.bottomAnchor, right:usernameLbl.leftAnchor, topConstant: 5 , leftConstant: 12, bottomConstant: 5, rightConstant: 8, widthConstant: 40, heightConstant: 40)
            usernameLbl.anchor(upperTab.topAnchor, left: profileImage.rightAnchor , bottom: upperTab.bottomAnchor, right: optionsMenu.leftAnchor, topConstant: 15, leftConstant: 8, bottomConstant: 15, rightConstant: 8, widthConstant: 0, heightConstant: 0  )
            optionsMenu.anchor(upperTab.topAnchor, left: usernameLbl.rightAnchor, bottom: upperTab.bottomAnchor, right: upperTab.rightAnchor, topConstant: 15, leftConstant: 8, bottomConstant: 15, rightConstant: 12, widthConstant: 20, heightConstant: 20)
    
    
            seprator.anchor(nil, left: upperTab.leftAnchor, bottom: upperTab.bottomAnchor, right: upperTab.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        
        
        
        
        
            usernameLbl.addTarget(self, action: #selector(toUserProfile), for: .touchDown)
//            let uigue = UITapGestureRecognizer(target: self, action: #selector(toUserProfile))
//            uigue.numberOfTapsRequired = 1
//          //  uigue.delegate = self as! UITapGestureRecognizerDe
//            profileImage.addGestureRecognizer(uigue)
        
        
    }
    
    
    
    
    
    func setupActivityTab()  {
        
        activityTab.addSubview(stepsTextField)
        activityTab.addSubview(addComment)
        stepsTextField.anchor(activityTab.topAnchor, left: addComment.rightAnchor, bottom: activityTab.bottomAnchor, right: activityTab.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        addComment.anchor(activityTab.topAnchor, left: activityTab.leftAnchor, bottom: activityTab.bottomAnchor, right: stepsTextField.leftAnchor, topConstant: 6, leftConstant: 12, bottomConstant: 6, rightConstant: 5, widthConstant: 80, heightConstant: 0)
        
        
        addComment.addTarget(self, action: #selector(createComment), for: .touchDown)
    }
    
    
    
    
    
    @objc func createComment(){
        
        if stepsTextField.text != "" {
            if let comment = stepsTextField.text {
            loadingProgress.showOnWindow()
            let parameters: Parameters = ["ad_id": ad_id,"customer_id":customer_id,"content":comment]
                
            //let parma: Parameters  = ["ad_id":1,"customer_id":1,"content":"hello world"]
            Alamofire.request(webURL.addcomment, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
                
            case .success :
                
                //print(response.data ?? <#default value#>)
                DispatchQueue.main.async {
                    if response.result.value != nil {

                      self.CustomizeLoadedData(data: response.data!)
                       
                    }

                }
                
                break;
                
            case .failure( let  error):
                //self.loadDone()
                print("error in load data \(error)")
               // print(response.data ?? )
                break;
                
                
                
            }
        }
                

                    
                
            }
        }else{
            
            let alert = Alerter.make(title: "Error", message: "Please Insert Message")
            del?.present(alert, animated: true, completion: nil)
        }
        
    }
    


    func CustomizeLoadedData(data: Data)  {
        
        
        do {
            
            
            let result = try JSONDecoder().decode(CommonUseModel.self, from: data)


            if result.status == 1 {
                let text = self.stepsTextField.text
               // let text = addComment
                let cmt = AdComments(id: result.id, customer_id: customer_id, ad_id: ad_id, comment_id: "0", content: text, created_at: "", updated_at: "")
                self.del?.comments.append(cmt)
                self.stepsTextField.text = ""
                self.del?.collectionView?.reloadData()
            }
            print(result)
        }catch{

            }
        
        loadingProgress.hideLoadingHubFromKeyWindow()
    }
    
    
    func setContactTab()  {
        ContactView.addSubview(likeImage)
        ContactView.addSubview(callImage)
        ContactView.addSubview(messageImage)
        ContactView.addSubview(adsPrice)
        
        
        likeImage.isHidden = true
        callImage.anchor(ContactView.topAnchor, left:ContactView.leftAnchor, bottom:ContactView.bottomAnchor, right: nil, topConstant: 8, leftConstant: 12, bottomConstant: 8, rightConstant: 0, widthConstant: 24, heightConstant: 24)
        
       // callImage.anchor(ContactView.topAnchor, left:likeImage.rightAnchor, bottom:ContactView.bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 24, heightConstant: 24)
        
        messageImage.anchor(ContactView.topAnchor, left:callImage.rightAnchor, bottom:ContactView.bottomAnchor, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 24, heightConstant: 24)
        
        
        adsPrice.anchor(ContactView.topAnchor, left: nil, bottom: ContactView.bottomAnchor, right: ContactView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
       // likeImage.addTarget(self, action: #selector(likeWeb), for: .touchDown)
        callImage.addTarget(self, action: #selector(callWeb), for: .touchDown)
        messageImage.addTarget(self, action: #selector(messageWeb), for: .touchDown)
    }
    
    
    
    @objc func toUserProfile()  {
        
        let controller = UserProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        // loadingProgress.show(view: self.view)
        controller.user_id =  customer_id
        controller.username = username
        self.del?.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    
    
    @objc func likeWeb() {
        
        
        
        
        
        print("Homne")
//        let item = ItemDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        item.toProfileActivity = 1
        //item.collectionView?.reloadData()
        //itemController.navgator
//        self.window?.rootViewController?.navigationController?.pushViewController(ItemDetailsViewController(), animated: true)

        //ItemDetailsViewController
         //let vc = ItemDetailsViewController()
        
        
      // del?.navigationController?.pushViewController(LoginViewController(),animated: true)
        
    }
    

    @objc func messageWeb() {
        print("message")
        
    }
    
    
    @objc func callWeb() {
        
       makeCall(phoneNumber: customer_phone)
    }
    
    
    
    func makeCall(phoneNumber: String) {
       let formattedNumber = phoneNumber.components(separatedBy:
       NSCharacterSet.decimalDigits.inverted).joined(separator: "")

       let phoneUrl = "tel://\(formattedNumber)"
       let url:NSURL = NSURL(string: phoneUrl)!

       if #available(iOS 10, *) {
          UIApplication.shared.open(url as URL, options: [:], completionHandler:
          nil)
       } else {
         UIApplication.shared.openURL(url as URL)
       }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

