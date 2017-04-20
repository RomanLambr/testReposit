//
//  ViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/18/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

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
            print("default browser was successfully opened")
       
        }
    }

}
