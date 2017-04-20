//
//  RoyalAssistViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/18/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class RoyalAssistViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ACTIONS
    
    @IBAction func makeCall(_ sender: Any) {
        
        if let phoneCallURL:URL = URL(string: "tel://\(Default.phoneNumber )") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                let alertController = UIAlertController(title: "Royal Assistent", message: "Are you sure you want to call \n\(Default.phoneNumber)?", preferredStyle: .alert)
                let yesPressed = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                })
                let noPressed = UIAlertAction(title: "No", style: .default, handler: { (action) in
                    
                })
                alertController.addAction(yesPressed)
                alertController.addAction(noPressed)
                present(alertController, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
}
