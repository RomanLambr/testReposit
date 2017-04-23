//
//  ViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/18/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit
fileprivate struct Def{
    static let identWhatToDoControler = "WhatToDoControler"
}
class RootViewController: UIViewController {

    //MARK: - Properties
    
    var instructions = [WhatList]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.red
        let logo = #imageLiteral(resourceName: "main_logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   //MARK: - Action
    @IBAction func actionOpenWeb(_ sender: Any) {
        if let url =  Default.link {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)       
        }
    }
    
    @IBAction func actionCallWhatToDoControler(_ sender: UIButton) {
        ServerManager.shared.getWhatToDoFromServer(success: { [weak self](instructions) in
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: Def.identWhatToDoControler ) as! WhatToDoControler
                vc.instructions = instructions
                self?.navigationController?.pushViewController(vc, animated: true)
            }, failure: { (error) in
                Default.showAlertMessage(vc: self, titleStr: "Error", messageStr: "No internet connection")
                
        })
    }
    
}
