//
//  NewAdViewController.swift
//  StoreApp
//
//  Created by MAC on 9/9/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import YPImagePicker


class NewAdViewController: UIViewController {
    var config = YPImagePickerConfiguration()
    var picker =  YPImagePicker()

    var isViewCanceled = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                
              //  self.dismiss(animated: true, completion: nil)
               self.isViewCanceled = 1
            }else if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                
                let vc = NewAdTxtDetailsViewController()
                vc.selectImage = photo.image
                self.navigationController?.pushViewController(vc, animated: true)
                picker.dismiss(animated: true, completion: nil)
            }
         picker.dismiss(animated: true, completion: nil)
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isViewCanceled == 0 {
            present(picker, animated: true, completion: nil)
        }else{
            
            
            // dismiss(animated: true, completion: nil)
            let vc = MainTabBar()
            self.navigationController?.navigationBar.barTintColor = main_color
            vc.navigationItem.hidesBackButton = true
            self.navigationItem.title = "Home"
            self.navigationController?.pushViewController(vc, animated: true)
           // picker.dismiss(animated: true, completion: nil)
        }
        
        //self.navigationController?.popViewController(animated: true)
        
        isViewCanceled = 0
    }
    
    

    

 
}
