//
//  AboutRoyalViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class AboutRoyalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        
        ServerManager.shared.getAboutRoyalAssist(success: { (about) in
            
        })
        
        // Do any additional setup after loading the view.
    }


}
