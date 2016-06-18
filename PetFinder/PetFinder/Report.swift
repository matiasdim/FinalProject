//
//  Report.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/6/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit

class Report {

    // MARK: - Attributes
    var petOwnerEmail: String?
    var reporterName: String?
    var reporterCel: String?
    var reporterPhone: String?
    var reporterEmail: String?
    var reporterObservations: String?
    var lat: String?
    var lon: String?
    var petId: String?
    
    let networkManager: NetworkManager = NetworkManager()
    
    
    // MARK: - Methods
    func create(successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        let parameters = ["reporter_name": reporterName!,
                          "reporter_cel": reporterCel!,
                          "reporter_observations": reporterObservations!,
                          "reporter_phone": "",
                          "reporter_email": reporterEmail!,
                          "lat": lat!,
                          "lon": lon!,
                          "pet_id": petId!]
        
        networkManager.createReport(parameters, successCallback:
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
    
    // MARK: - Validations
    func isValidEmail() -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(reporterEmail)
    }
    
}
