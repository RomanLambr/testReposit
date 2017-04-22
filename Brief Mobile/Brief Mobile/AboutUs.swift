//
//  AboutUs.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/22/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

struct AboutUs {
    
    var about       :String
    
    init?(json: [String: Any]) {
        guard let about = json["about_us"] as? String
            else {
                return nil
        }
        self.about = about
    }
}
