//
//  Report.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/6/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit

class Report {
    //To manage user defaults easly
    
    var petOwnerEmail: String?
    var reporterName: String?
    var reporterCel: String?
    var reporterPhone: String?
    var reporterEmail: String?
    var reporterObservations: String?
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
        let parameters = ["reporterNmail": reporterName!,
                          "reporterCel": reporterCel!,
                          "reporterObservations": reporterObservations!,
                          "reporterPhone": reporterPhone!,
                          "reporterEmail": reporterEmail!]
        
        networkManager.createReport(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
        
    }
    
    func detail(petId: String, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["reportId": petId]
        
        networkManager.showReport(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    func list(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["email": petOwnerEmail!]
        
        networkManager.listUserReports(parameters, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    //Validations
    func isValidEmail() -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(reporterEmail)
    }
    
}
