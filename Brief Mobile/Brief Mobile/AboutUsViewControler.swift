//
//  AboutUsViewControler.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/24/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import UIKit

class AboutUsViewControler: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var infoTextLabel:UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        loadDataFromApi()
    }
    //MARK: - Api
    func loadDataFromApi(){
        ServerManager.shared.getAboutFromServer(success: { (about) in
            self.infoTextLabel.textColor = Default.textColor
            self.infoTextLabel.text = about.text.htmlToString
        }, failure: { (error) in
            Default.showAlertMessage(vc: self, titleStr: "Error", messageStr: "No internet conection")
        })
    }

}
