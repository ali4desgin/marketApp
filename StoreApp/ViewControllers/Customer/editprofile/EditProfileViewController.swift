//
//  EditProfileViewController.swift
//  StoreApp
//
//  Created by MAC on 9/2/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController {
    let cellid = "cellid"
    let headerid = "headerid"
    let footerid = "footerid"
    
    var headersForSections = [
        "Basic Informations",
        "Profile Informations",
        "Bussiness Informations",
        "Security Option",
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    fileprivate func setupNavigationBar(){
        //self.navigationController?.tabBarController.ta
    }
    
    fileprivate func setupTableView(){
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: cellid)
//        tableView.register(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: headerid)
//        tableView.register(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: footerid)
//
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headersForSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headersForSections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = "row"
        return cell
    }
}
