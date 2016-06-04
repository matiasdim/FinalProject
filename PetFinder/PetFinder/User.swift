//
//  User.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class User {
    //To manage user defaults easly
    
    
    var email: String
    var password: String
    
    
    
    init?(email: String, password: String){
        if email.isEmpty || password.isEmpty {
            return nil
        }
        self.email = email
        self.password = password
    }
    
    func logUser(email: String) -> Void {
        Defaults[.emailKey] = self.email
        Defaults[.userAuthenticated] = true
        
    }
}
