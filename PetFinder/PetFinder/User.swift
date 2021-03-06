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
    // MARK: - Attributes
    var email: String
    var password: String!
    var name: String!
    var mobile: String!
    var reportsNum: String!
    
    let networkManager: NetworkManager = NetworkManager()
    
    // MARK: - Initializers
    init?(email: String){
        if email.isEmpty {
            return nil
        }
        self.email = email
    }
    
    init?(email: String, password: String){
        if email.isEmpty || password.isEmpty  {
            return nil
        }
        self.email = email
        self.password = password
    }
    
    init?(email: String, password: String, mobile: String, name: String){
        if email.isEmpty || password.isEmpty || name.isEmpty || mobile.isEmpty {
            return nil
        }
        self.email = email
        self.password = password
        self.name = name
        self.mobile = mobile
    }
    
    // MARK: - Methods
    func create(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["email": email,"password": password!, "name": name!, "mobile": mobile!]
        
        networkManager.createUser(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    func updateReportsNum(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["email": email, "reports_num": reportsNum!]
        
        networkManager.updateReportsNum(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    func login(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["email": email, "password": password!]
        
        networkManager.loginUser(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    // MARK: - Validations
    func isValidEmail() -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    func isValidPassword() -> Bool {
        // println("validate calendar: \(testStr)")
        if password.characters.count < 8{
            return false
        }
        return true
    }
    
}