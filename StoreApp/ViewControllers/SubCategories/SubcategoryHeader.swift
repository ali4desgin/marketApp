//
//  SubcategoryHeader.swift
//  Store
//
//  Created by MAC on 8/2/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
class SubcategoryHeader: UICollectionViewCell {
    
    let subcat_ref = SubCategoryViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    
    // searchFilter lbl
    let searchFilter: UITextField = {
        let  sampleTextField =  UITextField()
        sampleTextField.placeholder = "Search"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextBorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        //  sampleTextField.isSecureTextEntry = true
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        return sampleTextField
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Search", for: [])
        btn.backgroundColor = main_color
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        searchTrik()
    }
    
    
    
    func setupViews( )  {
        addSubview(searchFilter)
        addSubview(searchBtn)
        searchFilter.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: searchBtn.leftAnchor, topConstant: 8, leftConstant: 12, bottomConstant: 20, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        searchBtn.anchor(topAnchor, left: searchFilter.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 20, rightConstant: 12, widthConstant: 80, heightConstant: 0)
        
    }
    
    
    
    func searchTrik()    {
        searchBtn.addTarget(self, action: #selector(search), for:.touchDown)
        print("Search trik")
    }
    
    
    @objc func search( )  {
     //   let subcategory_search_text  = searchFilter.text
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

