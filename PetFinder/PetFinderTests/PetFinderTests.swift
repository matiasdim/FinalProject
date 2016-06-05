//
//  PetFinderTests.swift
//  PetFinderTests
//
//  Created by Matías  Gil Echavarría on 5/29/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import XCTest
@testable import PetFinder


class PetFinderTests: XCTestCase {
    
    // MARK: - Model tests
    
    //MARK: User model test
    func testUserInitialization() {
        // Success case.
        let user = User(email: "email@email.co", password: "123123123")
        XCTAssertNotNil(user)
        
        // Failure cases.
        let noEmailUser = User(email: "", password: "234234234")
        XCTAssertNil(noEmailUser, "Empty email is invalid")
        
        let noPasswordUser = User(email: "m@m.co", password: "")
        XCTAssertNil(noPasswordUser, "Empty password is invalid")
        
    }
    
    // MARK: - Network tests
    
    //MARK: User calls
    func testNetworkManagerCreateUser()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")

        let nm = NetworkManager()
        nm.createUser(["email": "m@m.test","password": "123"], successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. User created")
                asyncExpectation.fulfill()
            }) { (error) in
                XCTAssertNotNil(error, "WebServices succesfully called. User not created")
                asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testNetworkManagerLoginUser()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")
        
        let nm = NetworkManager()
        nm.loginUser(["email": "m@m.test","password": "123"], successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. User created")
                asyncExpectation.fulfill()
        }) { (error) in
            XCTAssertNotNil(error, "WebServices succesfully called. User not created")
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}
