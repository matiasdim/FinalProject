//
//  User.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Alamofire
//import NetworkManager

class User {
    //To manage user defaults easly
    
    let url: String
    var email: String
    var password: String
    
    
    
    init?(email: String, password: String){
        if email.isEmpty || password.isEmpty {
            return nil
        }
        self.email = email
        self.password = password
        self.url = "http://peaceful-gorge-92356.herokuapp.com"
    }
    
    func logUser(email: String) -> Void {
        Defaults[.emailKey] = self.email
        Defaults[.userAuthenticated] = true
        
    }

    func create(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = [
            "email": email,
            "password": password,
        ]
        let path = "/users/create"
        Alamofire.request(.POST, url + path, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    successCallback(response.result.value!)
                case .Failure(let error):
                    failCallback(error.description)
                }
        }
    }
    
    func login(successCallback: (AnyObject) -> (), failCallback: (String) -> ()){
        let parameters = [
            "email": email,
            "password": password,
            ]
        let path = "/users/update"
        Alamofire.request(.PUT, url + path, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:                    
                    successCallback(response.result.value!)
                case .Failure(let error):
                    failCallback(error.description)
                }
        }
    }
    
//    func createUser(successCallback: (CallbackSuccessBlock) -> Void, failCallback: (CallbackFailBlock) -> Void) -> Void
//    {
//        NetworkManager
//    }
}
