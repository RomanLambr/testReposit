//
//  Contact.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/24/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

struct Contact {
    var phone                   :String
    var paymentWebSite          :URL
    let eNsuredWebsite          :URL
    
    init?(json: [String: Any]) {
        guard let phone        = json["phone"] as? String,
            let paymentWebSite = json["royal_payment_website"] as? URL,
            let eNsuredWebsite = json["e_nsured_website"] as? URL
            else {
                return nil
        }
        self.phone = phone
        self.paymentWebSite = paymentWebSite
        self.eNsuredWebsite = eNsuredWebsite
    }
    
}
