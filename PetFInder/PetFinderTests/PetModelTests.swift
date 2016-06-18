//
//  PetModelTests.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/18/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import XCTest
@testable import PetFinder


class PetModelTests: XCTestCase {
    
     //MARK: Initializers
    func testLocationManagerNotNil() {
        // Success case.
        let petNoInitParams = Pet()
        XCTAssertNotNil(petNoInitParams.networkManager)
    }
    
    //MARK: Validations
    func testPetEmailValidation(){
        let petValidEmail = Pet()
        petValidEmail.email = "testemail@email.com"
        XCTAssertTrue(petValidEmail.isValidEmail(), "This is a valid email")
        
        let petInvalidEmail = Pet()
        petInvalidEmail.email = "asdqe23"
        XCTAssertFalse(petInvalidEmail.isValidEmail(), "This is an invalid email")
    }
    
}
