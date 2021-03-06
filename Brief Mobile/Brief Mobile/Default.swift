//
//  Default.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/18/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//
import UIKit

struct Default{
    static let  phoneNumber = "77777773"
    static let  link = URL(string: "https://www.jccsmart.com/eBills/Welcome/Index/9634031")
    static let  serverApi = "http://31.131.21.105:82"
    static let  textColor = UIColor(displayP3Red: 52.0/255.0, green: 53.0/255.0, blue: 137.0/255.0, alpha: 1)
    static let  googleMapApiKey = "AIzaSyBCAOt_Qdo_FWQ8km6aaFKZUXGdvmBO1oQ"
    static let  googleMapDirectionApi = "AIzaSyCzQIwxtogINN4W0yI9AVLKIBKzvyeY7sk"
    static func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
}
