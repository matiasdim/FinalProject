//
//  Pet.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class Pet  {
    //To manage user defaults easly
    
    var email: String?
    var name: String?
    var observations: String?
    var petId: String?
    
    let networkManager: NetworkManager = NetworkManager()
//
//    init?(email: String, name: String, observations: String){
//        if email.isEmpty || name.isEmpty {
//            return nil
//        }
//        self.email = email
//        self.name = name
//        self.observations = observations
//    }
//    

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
    
}