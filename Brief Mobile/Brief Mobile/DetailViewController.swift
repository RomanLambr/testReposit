//
//  DetailViewController.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/23/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK - IBOutlet
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    //MARK: - Properties
    var service : Service? = nil
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        fillingView()
    }
    
    //MARK: - Fill View
    
    func fillingView(){
        guard let service = service else {
            return
        }
        infoTextLabel.textColor = Default.textColor
        infoTextLabel.text = service.description.htmlToString
        self.navigationItem.title = service.title
    }
    //MARK: - IBAction
    @IBAction func goToWebSiteAction(_ sender: Any) {
        
        if let url = service?.website  {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    
    }
    

}
