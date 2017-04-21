//
//  File.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/21/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func underlined(){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = Default.textColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.insertSublayer(border, at: 1)
        self.layer.masksToBounds = true
    }
    func deunderlined(){
        self.layer.sublayers?.remove(at: 1)
    }
}
