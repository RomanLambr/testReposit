//
//  File.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//


import UIKit

extension UIViewController{
    func configNavigationBar(){
        
        
        let image1 = #imageLiteral(resourceName: "back_icon").withRenderingMode(.alwaysOriginal)
        let backButton: UIBarButtonItem = UIBarButtonItem(image: image1 , style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem  = backButton
        let image2 = #imageLiteral(resourceName: "red_logo_icon").withRenderingMode(.alwaysOriginal)
        let backToRootButton: UIBarButtonItem = UIBarButtonItem(image:  image2 , style: .plain, target: self, action: #selector(backtoRoot))
       
        self.navigationItem.rightBarButtonItem = backToRootButton
    
    }
        func back() {
    _ = self.navigationController?.popViewController(animated: true)
    
        }

        func backtoRoot(){
    _ = self.navigationController?.popToRootViewController(animated: true)
        }

    }
