//
//  NetworkManager.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/4/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import Alamofire
import AVReachability

typealias CallbackSuccessBlock = (AnyObject)
typealias CallbackFailBlock = (String)

class NetworkManager {
    
    let manager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    let url = "http://peaceful-gorge-92356.herokuapp.com"
    
    // MARK: - Basic calls
    
    func basicPost(apiPath: String,
                   parameters: Dictionary<String, String>,
                   timeOut: Int,
                   successCallback: (CallbackSuccessBlock) -> Void,
                   failCallback: (CallbackFailBlock) -> Void) -> Void
    {
        Alamofire.request(.POST, url + apiPath, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    successCallback((response.result.value as? [String: AnyObject])!)
                case .Failure(let error):
                    failCallback(error.description)
                }
        }
    }
    
    func basicPut(apiPath: String,
                   parameters: Dictionary<String, String>,
                   timeOut: Int,
                   successCallback: (CallbackSuccessBlock) -> Void,
                   failCallback: (CallbackFailBlock) -> Void) -> Void
    {
        Alamofire.request(.PUT, url + apiPath, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    successCallback((response.result.value as? [String: AnyObject])!)
                case .Failure(let error):
                    failCallback(error.description)
                }
        }
    }
    
    func basicGet(apiPath: String,
                  timeOut: Int,
                  successCallback: (CallbackSuccessBlock) -> Void,
                  failCallback: (CallbackFailBlock) -> Void) -> Void
    {
        Alamofire.request(.GET, url + apiPath, parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    successCallback((response.result.value)!)
                case .Failure(let error):
                    failCallback(error.description)
                }
        }
    }
    
    // MARK: - User calls
    
    func createUser(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicPost("/users/create", parameters: parameters, timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
            }) {(error) in
                failCallback(error)
            }
    }
    
    func loginUser(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        
        basicPost("/users/update", parameters: parameters, timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
            }) { (error) in
                failCallback(error)
            }
    }
    func updateReportsNum(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicPut("/users/update/reports", parameters: parameters, timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    
     // MARK: - Pet calls
    func createPet(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicPost("/pets", parameters: parameters, timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
        }) {(error) in
            failCallback(error)
        }
    }
    
    func listUserPets(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicGet("/pets?email=\(parameters["email"]!)", timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    func showPet(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicGet("/pets/\(parameters["petId"]!)", timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    // MARK: - Report calls
    func createReport(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicPost("/reports", parameters: parameters, timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
        }) {(error) in
            failCallback(error)
        }
    }
    
    func listUserReports(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicGet("/reports?email=\(parameters["email"]!)", timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    func showReport(parameters: Dictionary<String,String>, successCallback: (AnyObject) -> (), failCallback: (String) -> ())
    {
        basicGet("/reports/\(parameters["reportId"])", timeOut: 240, successCallback:
            { (response) in
                successCallback(response)
        }) { (error) in
            failCallback(error)
        }
    }
    
    // Connection validator
    static func isInternetReachable() -> Bool {
        return Reachability.isConnectedToNetwork()
    }

    
}
