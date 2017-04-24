//
//  AboutRoyalViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class AboutRoyalViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var infoTextLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadApiFromServer()
    }
    
    //MARK: - Load Data from server
    func loadApiFromServer(){
        ServerManager.shared.getAboutRoyalAssistFromServer(success: { (about) in
            self.infoTextLabel.text = about.text.htmlToString
            self.infoTextLabel.textColor = Default.textColor
        }, failure: { (error) in
            Default.showAlertMessage(vc: self, titleStr: "Error", messageStr: "No internet conection")
        })
    }
}
