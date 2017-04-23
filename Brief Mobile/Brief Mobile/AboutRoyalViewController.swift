//
//  AboutRoyalViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class AboutRoyalViewController: UIViewController {
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       ServerManager.shared.getAboutRoyalAssistFromServer(success: { [](about) in
            self.infoTextLabel.text = about.text.htmlToString
            self.infoTextLabel.textColor = Default.textColor
       }, failure: { (error) in
            Default.showAlertMessage(vc: self, titleStr: "Error", messageStr: "No internet conection")
       })
        
    }
    
}
