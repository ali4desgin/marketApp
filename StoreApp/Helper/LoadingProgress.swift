//
//  LoadingProgress.swift
//  Store
//
//  Created by MAC on 7/31/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import JGProgressHUD
import RSLoadingView


class LoadingProgress {
    let prog = JGProgressHUD(style: .extraLight)
    
    init() {
        
        prog.textLabel.text = "Loading"
        // hud.show(in: self.view)
        // hud.dismiss(afterDelay: 3.0
    }
    
    public  func show(view: UIView){
        prog.show(in: view)
    }
    
    
    public  func hide(){
        prog.dismiss(afterDelay: 0.0)
        
    }
    
    
     func showLoadingHub(view:UIView) {
        let loadingView = RSLoadingView(effectType: RSLoadingView.Effect.twins)
        loadingView.show(on: view)
    }
    
     func showOnViewTwins(view:UIView) {
        let loadingView = RSLoadingView(effectType: RSLoadingView.Effect.twins)
        loadingView.show(on: view)
    }
    
    func hideLoadingHub(view:UIView) {
        RSLoadingView.hide(from: view)
    }
    
     func showOnWindow() {
        let loadingView = RSLoadingView()
        loadingView.showOnKeyWindow()
    }
    
    func hideLoadingHubFromKeyWindow() {
        RSLoadingView.hideFromKeyWindow()
    }
}

