//
//  Branch.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/21/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

struct Branch {
    
    var id          :Int
    var title       :String
    let address     :String
    let phone       :String
    let fax         :String
    let email       :String
    let postalCode  :String
    var latitude    :Double
    var longitude   :Double
    var position    :CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
    }
    
    init?(json: [String: Any]) {
        guard let id        = json["id"] as? Int,
            let title       = json["title"] as? String,
            let address     = json["address"] as? String,
            let phone       = json["phone"] as? String,
            let fax         = json["fax"] as? String,
            let email       = json["email"] as? String,
            let postalCode  = json["postal_code"] as? String,
            let latitude    = json["latitude"] as? Double,
            let longitude   = json["longitude"] as? Double
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.address = address
        self.phone = phone
        self.fax = fax
        self.email = email
        self.postalCode = postalCode
        self.latitude = latitude
        self.longitude = longitude
    }
}
