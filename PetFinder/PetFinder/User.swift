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
    let networkManager: NetworkManager = NetworkManager()
    
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
        let parameters = ["email": email,"password": password]
        
        networkManager.createUser(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    func login(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["email": email, "password": password]
        
        networkManager.loginUser(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
}