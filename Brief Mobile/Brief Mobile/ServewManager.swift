//
//  ServewManager.swift
//  Brief Mobile
//
//  Created by Roma Lambr on 4/19/17.
//  Copyright © 2017 Roma Lambr. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager {
    
    static let shared = ServerManager()
    private init() {}
    
    // MARK: - GET methods
    func getAboutRoyalAssistFromServer(success:@escaping (AboutRoyalAssist) -> Void, failure:@escaping (Error?) -> Void){
        let strURL = Default.serverApi + "/api/v1/about_royal_assist"
        Alamofire.request(strURL,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
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
    
    func getAboutFromServer(success:@escaping (AboutUs) -> Void, failure:@escaping (Error?) -> Void){
        let strURL = Default.serverApi + "/api/v1/about_us"
        Alamofire.request(strURL,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) -> Void in
                if response.result.isSuccess {
                    guard let value = response.result.value as? [String: Any],
                            let about = AboutUs.init(json: value) else {
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
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) -> Void in
                if response.result.isSuccess {
                    guard let branchesArray = response.result.value as? [[String: Any]]  else { return }
                    let branches = branchesArray.flatMap { Branch(json: $0) }
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
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) -> Void in
                if response.result.isSuccess {
                    guard let instructionsArray = response.result.value as? [[String: Any]] else {
                        return
                    }
                    let list = instructionsArray.flatMap { WhatList(json: $0)}
                    success(list)
                }
                if response.result.isFailure {
                    let error = response.result.error
                    failure(error)
                }
        }
    }
    
    func getServicesFromServer(perPage: Int, servicseType: String,  success: @escaping ([Service]) -> Void, failure: @escaping (Error?) -> Void) {
        let strURL = Default.serverApi + "/api/v1/services"
        let parameters : [String : Any] = ["per_page" : perPage, "service_type" : servicseType]
        Alamofire.request(strURL,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) -> Void in
                if response.result.isSuccess {
                    guard let instructionsArray = response.result.value as? [[String: Any]]  else {
                        return
                    }
                    let services = instructionsArray.flatMap { Service(json: $0) }
                    success(services)
                }
                if response.result.isFailure {
                    let error = response.result.error
                    failure(error)
                }
        }
    }
    
    func getContact(success:@escaping (Contact) -> Void, failure:@escaping (Error?) -> Void){
        let strURL = Default.serverApi + "/api/v1/contacts"
        Alamofire.request(strURL,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) -> Void in
                if response.result.isSuccess {
                    guard let value = response.result.value as? [String: Any],
                            let contact = Contact.init(json: value) else { return
                    }
                    success(contact)
                }
                if response.result.isFailure {
                    let error = response.result.error
                    failure(error)
                }
        }
    }
    //MARK: - Post Method
        
    func sendReportToServer (request : AccidentRequest , images : [UIImage], success: @escaping (Any?) -> Void, failure: @escaping (Error?) -> Void, progressValue: @escaping (Float) -> Void) {
        let parameters = request.dictionaryRepresent()
        let strURL = Default.serverApi + "/api/v1/accident_reports"
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key,value) in parameters {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                for (index,image) in images.enumerated() {
                    if  let imageData = UIImageJPEGRepresentation(image, 1) {
                        multipartFormData.append(imageData, withName: "image\(index)", fileName: "image\(index).jpeg", mimeType: "image\(index)/jpeg")
                    }
                }
        },
            to: strURL,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress {  progress in
                        progressValue(Float(progress.fractionCompleted))
                    }
                    upload.responseJSON {  response in
                        success(response.result.value)
                    }
                case .failure(let encodingError):
                        failure(encodingError)
                        print(encodingError)
                    }
        } )
    }
}
