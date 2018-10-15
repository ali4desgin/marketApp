//
//  CreateNewAdViewController.swift
//  StoreApp
//
//  Created by MAC on 8/30/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import Alamofire
import SkyFloatingLabelTextField
import AssetsLibrary
import PhotosUI

import YPImagePicker

class CreateNewAdViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    // Build a picker with your configuration
    let picker = YPImagePicker()

    
    let deatilsView: UIView = {
       let view1 = UIView()
        view1.backgroundColor  = UIColor(white: 1, alpha: 0.8)
        view1.isHidden = true
        view1.layer.cornerRadius = 5
        return view1
    }()
    
    
    
    var actionSheet: UIAlertController = UIAlertController()
    var tabbarheight:CGFloat!
    var imagePicker = UIImagePickerController()
    var checkImg = true
    
    var profileImageData  = UIImageJPEGRepresentation(#imageLiteral(resourceName: "user1"), 0.5)!
    
    var profileImageName = ""
    
    
    
    
    let backView : UIImageView = {
       let bg = UIImageView()
        bg.image = #imageLiteral(resourceName: "addphoto").withRenderingMode(.alwaysTemplate)
        bg.tintColor = white_color
        bg.contentMode = .scaleAspectFit
        return bg
    }()
//
    
    
//    let box1 : UIView = {
//       let view1 = UIView()
//        view1.backgroundColor = .red
//        return view1
//    }()
//    let box2 : UIView = {
//        let view1 = UIView()
//        view1.backgroundColor = .green
//        return view1
//    }()
//
//    let scrollV:UIScrollView = {
//        let view1 = UIScrollView()
//        view1.backgroundColor = .blue
//        view1.alwaysBounceVertical = true
//        view1.isScrollEnabled = true
//        return view1
//    }()
//
//
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         //showImagePicker()
//        picker.didFinishPicking { [unowned picker] items, _ in
//            if let photo = items.singlePhoto {
//                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.
//            }
//            picker.dismiss(animated: true, completion: nil)
//        }
//
        present(picker, animated: true, completion: nil)

      // self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        self.view.addSubview(backView)
        self.view.addSubview(deatilsView)
        backView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        deatilsView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 200, leftConstant: 40, bottomConstant: 200, rightConstant: 40, widthConstant: 0, heightConstant: 0)
//        view.backgroundColor = white_color
//        view.addSubview(scrollV)
//        scrollV.translatesAutoresizingMaskIntoConstraints = false
//        scrollV.frame = view.frame
//
//        scrollV.addSubview(box1)
//        box1.translatesAutoresizingMaskIntoConstraints = false
//       box1.frame = CGRect(x: 0, y: 0, width: scrollV.bounds.width, height: 600)
//
//
//        scrollV.addSubview(box2)
//        box2.translatesAutoresizingMaskIntoConstraints = false
//        box2.frame = CGRect(x: 0, y: 600, width: scrollV.bounds.width, height: 600)
//
//        scrollV.contentSize = CGSize(width: scrollV.bounds.width, height: 1200)
//
//
       //showImagePicker()
        
        present(picker, animated: true, completion: nil)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            }
            picker.dismiss(animated: true, completion: nil)
        }

//
        
//        scrollV.addSubview(box2)
//        box1.anchor(scrollV.topAnchor, left: scrollV.leftAnchor, bottom: nil, right: scrollV.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 3000)
//        box2.anchor(box1.bottomAnchor, left: scrollV.leftAnchor, bottom: nil, right: scrollV.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 3000)

//        view.frame.size.height = box1.frame.size.height + box2.frame.size.height
    
    }
    
    
    
    func setupViews() {
        
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }
  
    
    
    
    func showImagePicker(){
        
         actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
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
        profileImageData = UIImageJPEGRepresentation(image, 1)!
        
        self.backView.image = image
        
        //self.imageProfile.imageView?.contentMode = .scaleToFill
        
        
       actionSheet.popoverPresentationController?.dismissalTransitionWillBegin()
        
        
        imagePicker.dismiss(animated: true) {
            
            UIView.animate(withDuration: 1000, animations: {
                self.deatilsView.isHidden = false
            }, completion: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
      
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // print("Diss")
        dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    
    
    
}
