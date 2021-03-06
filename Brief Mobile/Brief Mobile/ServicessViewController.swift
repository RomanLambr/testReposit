//
//  ServicessViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit
fileprivate struct Def{
    static let idenServiceTableViewControler = "ServiceTableViewControler"
}
fileprivate enum Type : String{
    case personal = "personal"
    case business = "business"
}
class ServicessViewController: UIViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
    }
    
    //MARK: - IBActions
    @IBAction func callBusinessServises(_ sender: Any) {
        getServicesFromApi(type: .business)
    }
    
    @IBAction func callPersonalServises(_ sender: Any) {
        getServicesFromApi(type: .personal)
    }
    
    private func getServicesFromApi(type : Type){
        ServerManager.shared.getServicesFromServer(perPage: 20, servicseType: type.rawValue, success: { [weak self](services) in
            let viewControler = self?.storyboard?.instantiateViewController(withIdentifier: Def.idenServiceTableViewControler) as! ServicesTableViewController
            viewControler.services = services
            viewControler.navigationItem.title = type.rawValue.capitalized
            self?.navigationController?.pushViewController(viewControler, animated: true)
            }, failure: { (error) in
                Default.showAlertMessage(vc: self, titleStr: "Error", messageStr: "No internet connection")
        })
    }
}
