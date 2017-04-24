//
//  ServicesTableViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/23/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit
fileprivate struct Def{
    static let detailViewControllerIdent = "DetailViewControler"
}

class ServicesTableViewController: UITableViewController {
    
    //MARK: - Properties
    var services = [Service]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
    }
}

//MARK: - UITableViewDataSource
extension ServicesTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseServiceIdentifier")
        
        if cell == nil {
            cell = UITableViewCell(style: .default , reuseIdentifier: "reuseServiceIdentifier")
        }
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = services[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}

//MARK: - UITableViewDelegate
extension ServicesTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: Def.detailViewControllerIdent) as! DetailViewController
        viewController.service = services[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
