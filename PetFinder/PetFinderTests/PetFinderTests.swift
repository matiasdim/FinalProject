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
    
    func testMealInitialization() {
        // Success case.
        let user = User(email: "email@email.co", password: "123123123")
        XCTAssertNotNil(user)
        
        // Failure cases.
        let noEmailUser = User(email: "", password: "234234234")
        XCTAssertNil(noEmailUser, "Empty email is invalid")
        
        let noPasswordUser = User(email: "m@m.co", password: "")
        XCTAssertNil(noPasswordUser, "Empty password is invalid")
        
    }

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.c
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

/*
 func testMealInitialization() {
 // Success case.
 let user = User(email: "email@email.co", password: "123123123")
 XCTAssertNotNil(user)
 
 // Failure cases.
 let noEmailUser = User(email: "", password: "234234234")
 XCTAssertNil(noEmailUser, "Empty email is invalid")
 
 let noPasswordUser = User(email: "m@m.co", password: "")
 XCTAssertNil(noPasswordUser, "Empty password is invalid")
 
 }
 */




