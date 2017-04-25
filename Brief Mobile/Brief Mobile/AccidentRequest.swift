//
//  AccidentRequest.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/25/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation

class AccidentRequest{
    //MARK: - String keys
    private struct StringKeys{
        static let name = "name"
        static let regNumber = "reg_policy_number"
        static let phoneNumber = "phone_number"
    }
    
    //MARK: - Properties
    let name : String?
    let regNumber : String?
    let phoneNumber :String?
    
    //MARK: - Init
    init (name: String?, regNumber: String?, phoneNumber: String?){
        self.name = name
        self.regNumber = regNumber
        self.phoneNumber = phoneNumber
    }
    
    func dictionaryRepresent() -> [String:Any]{
        var dictionary : [String:Any] = [:]
        if let value = name { dictionary[StringKeys.name] = value }
        if let value = regNumber { dictionary[StringKeys.regNumber] = value }
        if let value = phoneNumber { dictionary[StringKeys.phoneNumber] = value }
        return dictionary
    }
}
