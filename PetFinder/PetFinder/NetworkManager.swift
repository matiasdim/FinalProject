//
//  NetworkManager.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/4/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import Alamofire

typealias CallbackSuccessBlock = ([String: AnyObject])
typealias CallbackFailBlock = (String)

class Manager: NSObject {
    
    let manager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    override init()
    {
        super.init()
//        startMonitoringInternet()
    }
//    func basicPost(<#parameters#>) -> <#return type#> {
//        Alamofire.upload(
//            .POST,
//            "http://api.imagga.com/v1/content",
//            headers: ["Authorization" : "Basic xxx"],
//            multipartFormData: { multipartFormData in
//                multipartFormData.appendBodyPart(data: imageData, name: "imagefile",
//                    fileName: "image.jpg", mimeType: "image/jpeg")
//            },
//            encodingCompletion: { encodingResult in
//            }
//        )
//    }
//    
//    func basicPut(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }

    
    func basicGet(apiPath: String, timeOut: Int, successCallback: (CallbackSuccessBlock) -> Void, failCallback: (CallbackFailBlock) -> Void) -> Void
    {
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
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
    
    func createuser(email: String, password: String, successCallback: (CallbackSuccessBlock) -> Void, failCallback: (CallbackFailBlock) -> Void) -> Void
    {
        basicGet("users/create?password=\(password)&email=\(email)", timeOut: 240, successCallback:
        { (CallbackSuccessBlock) in
            successCallback(CallbackSuccessBlock)
        }) { (CallbackFailBlock) in
            failCallback(CallbackFailBlock)
        }
    }


//    func startMonitoringInternet() -> Bool{
//        manager?.listener = { status in
//            switch status {
//            case .NotReachable:
//                return false
//                break
//            case .Reachable(_), .Unknown:
//                return true
//                break
//            }
//            default
//                return false
//                break
//        }
//        manager?.startListening()
//    }

}
