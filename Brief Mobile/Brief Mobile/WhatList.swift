//
//  WhatList.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/22/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

/*{
    "id": 8,
    "title": "Leaving on Holiday",
    "tabs": false,
    "tab_1_title": "Leaving on holiday",
    "tab_1_content": "<p><strong>Switch off all electricty, water, gas</strong>, and cover the solar heater glass.\r\n</p>\r\n<p>Switch off all heaters and air-conditioning.\r\n</p>\r\n<p><em>Unplug all radios and televisions.</em>\r\n</p>\r\n<p>Unplug the television aerial (as there is a risk of lightning damage).\r\n</p>\r\n<p><u>Empty the fridge and leave the door open.</u>\r\n</p>\r\n<p>Ensure that plants and/or pets are being taken care of during your absence.\r\n</p>\r\n<p><strong>Leave a set of keys to a trusted person, in case of an emergency.</strong>\r\n</p>\r\n<p>Shut doors and windows tight.\r\n</p>\r\n<p>Ask a neighbour to empty your mailbox so that your long absence is not provocatively apparent (burglary risk).\r\n</p>",
    "tab_2_title": "",
    "tab_2_content": ""
}*/

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
