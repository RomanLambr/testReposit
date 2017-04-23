//
//  ServewManager.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation
import Alamofire

protocol ServerManagerProtocol: class {
    func updateHandler(_ response: Any?)
    func errorHandler(_ error: Error?)
}

// MARK: - GET methods
class ServerManager {
    
    static let shared = ServerManager()
    private init() {}
    
    weak var delegate: ServerManagerProtocol?
            
    func getAboutRoyalAssistFromServer(success:@escaping (AboutRoyalAssist) -> Void, failure:@escaping (Error?) -> Void){
        let strURL = Default.serverApi + "/api/v1/about_royal_assist"
        Alamofire.request(strURL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
                         .responseJSON { (response) -> Void in
                    
            if response.result.isSuccess {
                guard let value = response.result.value as? [String: Any],
                let about = AboutRoyalAssist.init(json: value) else {
                    return
                }
                success(about)
                
            }
            if response.result.isFailure {
                let error = response.result.error
                    failure(error)
            }
    
        }
    }
    
    func getBranchesFromServer(success:@escaping ([Branch]) -> Void, failure:@escaping (Error?) -> Void){
        let strURL = Default.serverApi + "/api/v1/branches"
        Alamofire.request(strURL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON { (response) -> Void in
               
                if response.result.isSuccess {
                    guard let branchesArray = response.result.value as? [[String: Any]]  else {
                            return
                    }
                    let branches = branchesArray.flatMap { Branch(json: $0)}
                    success(branches)
                    
                }
                if response.result.isFailure {
                    let error = response.result.error
                    failure(error)
                }
                
        }
    }
    
    func getWhatToDoFromServer(success:@escaping ([WhatList]) -> Void, failure:@escaping (Error?) -> Void){
        let strURL = Default.serverApi + "/api/v1/accident_instructions"
        Alamofire.request(strURL,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .responseJSON { (response) -> Void in
                
                if response.result.isSuccess {
                    guard let branchesArray = response.result.value as? [[String: Any]]  else {
                        return
                    }
                    let list = branchesArray.flatMap { WhatList(json: $0)}
                    success(list)
                    
                }
                if response.result.isFailure {
                    let error = response.result.error
                    failure(error)
                }
                
        }

    }
}
