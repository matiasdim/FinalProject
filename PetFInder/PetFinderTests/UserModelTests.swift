//
//  UserModelTests.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/18/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import XCTest
@testable import PetFinder

class UserModelTests: XCTestCase {
    
    //MARK: Initializers
    func testUserInitializationEmailPass() {
        // Success case.
        
        let user = User(email: "email@email.co", password: "123123123")
        XCTAssertNotNil(user)
        
        // Failure cases.
        let noEmailUser = User(email: "", password: "123123123")
        XCTAssertNil(noEmailUser, "Empty email is invalid")
        
        let noPasswordUser = User(email: "email@email.co", password: "")
        XCTAssertNil(noPasswordUser, "Empty password is invalid")
        
    }
    
    func testUserInitializationEmailPassMobName() {
        let user = User(email: "email@email.co", password: "123123123", mobile: "838167812", name: "TestName")
        XCTAssertNotNil(user)
        
        // Failure cases.
        let noEmailUser = User(email: "", password: "123123123", mobile: "838167812", name: "TestName")
        XCTAssertNil(noEmailUser, "Empty email is invalid")
        
        let noPasswordUser = User(email: "email@email.co", password: "", mobile: "838167812", name: "TestName")
        XCTAssertNil(noPasswordUser, "Empty password is invalid")
        
        let noMobileUser = User(email: "email@email.co", password: "234233", mobile: "", name: "TestName")
        XCTAssertNil(noMobileUser, "Empty Mobile number is invalid")
        
        let noNameUser = User(email: "email@email.co", password: "123234", mobile: "838167812", name: "")
        XCTAssertNil(noNameUser, "Empty name is invalid")
    }
    
    func testUserInitializationEmail() {
        let user = User(email: "email@email.co", password: "123123123", mobile: "838167812", name: "TestName")
        XCTAssertNotNil(user)
        
        // Failure cases.
        let noEmailUser = User(email: "", password: "123123123", mobile: "838167812", name: "TestName")
        XCTAssertNil(noEmailUser, "Empty email is invalid")
        
        let noPasswordUser = User(email: "email@email.co", password: "", mobile: "838167812", name: "TestName")
        XCTAssertNil(noPasswordUser, "Empty password is invalid")
        
        let noMobileUser = User(email: "email@email.co", password: "234233", mobile: "", name: "TestName")
        XCTAssertNil(noMobileUser, "Empty Mobile number is invalid")
        
        let noNameUser = User(email: "email@email.co", password: "123234", mobile: "838167812", name: "")
        XCTAssertNil(noNameUser, "Empty name is invalid")
    }
    
    
    
    //MARK: Validations
    func testUserEmailValidation(){
        let userValidEmail = User(email: "email@email.co", password: "123123123")
        XCTAssertTrue(userValidEmail!.isValidEmail(), "This is a valid email")
        
        let userInvalidEmail = User(email: "This is not an email", password: "123123123")
        XCTAssertFalse(userInvalidEmail!.isValidEmail(), "This is an invalid email")
    }

    func testUserPasswordValidation(){
        let userValidPassword = User(email: "email@email.co", password: "123123123")
        XCTAssertTrue(userValidPassword!.isValidPassword(), "This is a valid password")
        
        let userInvalidPassword = User(email: "This is not an email", password: "1234567")
        XCTAssertFalse(userInvalidPassword!.isValidPassword(), "This is an invalid password")
    }
    
}
