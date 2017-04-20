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
    
    func getAboutRoyalAssist(success: @escaping (_ aboutInfo :String) -> ()) {
        
        let dictParameters = [:] as [String : Any]
        
        let url = URL(string: Default.serverApi + "/api/v1/about_royal_assist")!
        
        Alamofire.request(
            url,
            method: .get,
            parameters: dictParameters)
            .validate()
            .responseJSON { [weak self] (response) -> Void in
                guard response.result.isSuccess else {
                    self?.delegate?.errorHandler(response.error)
                    print("Error while fetching info: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let about = value["about_royal_assist"] as? String else {
                        print("Malformed data received from fetch")
                        return
                }
                
                print(about)
                /*
                 var userArray = [RLUser]()
                 for friend in friendsDictArray{
                 guard let user = RLUser(json: friend) else {
                 print( "Could not create User object from JSON")
                 return
                 }
                 userArray.append(user)
                 } equel
                 */
                
                //let users = friendsDictArray.flatMap { RLUser(json: $0)}
                /*for user in users{
                    print(user.firstName ?? "")
                }*/
                success(about)
        }
        
    }
    
    
}
