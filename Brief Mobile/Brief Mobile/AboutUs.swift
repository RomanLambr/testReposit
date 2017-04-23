//
//  AboutUs.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/22/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

struct AboutUs {
    
    var text:String
    
    init?(json: [String: Any]) {
        guard let text = json["about_us"] as? String
            else {
                return nil
        }
        self.text = text
    }
}
