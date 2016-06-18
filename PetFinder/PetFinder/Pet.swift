//
//  Pet.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class Pet {
    
    // MARK: - Attrbiutes
    var email: String?
    var name: String?
    var observations: String?
    var petId: String?
    
    let networkManager: NetworkManager = NetworkManager()

    // MARK: - Methods
    func create(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["email": email!,"name": name!, "observations": observations!]
        networkManager.createPet(parameters, successCallback:
            { (response) in
                successCallback(response)
            }) { (error) in
                failCallback(error)
        }
        
    }
    
    func detail(petId: String, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["petId": petId]
        
        networkManager.showPet(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    func list(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["email": email!]
        
        networkManager.listUserPets(parameters, successCallback:
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
    
}