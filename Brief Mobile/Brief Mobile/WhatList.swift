//
//  WhatList.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/22/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

struct WhatList {
    
    var id          :Int
    var title       :String
    let tabs        :Bool
    let tab1Title   :String
    let tab1Content :String
    let tab2Title   :String
    let tab2Content :String
    
    init?(json: [String: Any]) {
        guard let id        = json["id"] as? Int,
            let title       = json["title"] as? String,
            let tabs        = json["tabs"] as? Bool,
            let tab1Title   = json["tab_1_title"] as? String,
            let tab1Content = json["tab_1_content"] as? String,
            let tab2Title   = json["tab_2_title"] as? String,
            let tab2Content = json["tab_2_content"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.tabs = tabs
        self.tab1Title = tab1Title
        self.tab1Content = tab1Content
        self.tab2Title = tab2Title
        self.tab2Content = tab2Content
    }
}
