//
//  Servise.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/23/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

struct Service {
    var id          :Int
    var title       :String
    let website     :URL?
    let type        :String
    let description :String
    
    init?(json: [String: Any]) {
        guard let id        = json["id"] as? Int,
            let title       = json["title"] as? String,
            let website     = json["website"] as? String,
            let type        = json["type"] as? String,
            let description = json["description"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.website = URL.init(string: website)
        self.type = type
        self.description = description
    }

}
