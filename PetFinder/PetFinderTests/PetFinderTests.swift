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
    
    //MARK: User model validations
    func testUserValidations(){
        let userValidEmail = User(email: "email@email.co", password: "123123123")
        XCTAssertTrue(userValidEmail!.isValidEmail(), "This is a valid email")
        
        let userInvalidEmail = User(email: "This is not an email", password: "123123123")
        XCTAssertFalse(userInvalidEmail!.isValidEmail(), "This is an invalid email")
    }
    
    //MARK: Pet model test
    func testPetInitialization() {
        // Success case.
        let petNoInitParams = Pet()
        XCTAssertNotNil(petNoInitParams)
        
        // Failure cases.
        let setEmailToPet = Pet()
        setEmailToPet.email = "email@email.com"
        XCTAssertNotNil(setEmailToPet.email)
        
        let setNameToPet = Pet()
        setNameToPet.name = "Pet Name"
        XCTAssertNotNil(setNameToPet)
        
        let setObservationsToPet = Pet()
        setObservationsToPet.observations = "The observations"
        XCTAssertNotNil(setObservationsToPet)
    }
    
    //MARK: Pet model validations
    func testPetValidations(){
        let petValidEmail = Pet()
        petValidEmail.email = "testemail@email.co"
        XCTAssertTrue(petValidEmail.isValidEmail(), "This is a valid email")
        
        let petInvalidEmail = Pet()
        petInvalidEmail.email = "this is not an email"
        XCTAssertFalse(petInvalidEmail.isValidEmail(), "This is an invalid email")
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
    
    //MARK: Pet calls
    func testNetworkManagerCreatePet()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")
        
        let nm = NetworkManager()
        nm.createPet(["email": "m@m.test","name": "A Name", "observations": "An Observation"], successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. Pet created")
                asyncExpectation.fulfill()
        }) { (error) in
            XCTAssertNotNil(error, "WebServices succesfully called. Pet not created")
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testNetworkManagerListUserPets()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")
        
        let nm = NetworkManager()
        nm.listUserPets(["email": "m@m.test"], successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. Pets fetched")
                asyncExpectation.fulfill()
        }) { (error) in
            XCTAssertNotNil(error, "WebServices succesfully called. Pets not fetched")
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testNetworkManagerShowPets()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")
        
        let nm = NetworkManager()
        nm.showPet(["petId": "1"], successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. Pet fetched")
                asyncExpectation.fulfill()
        }) { (error) in
            XCTAssertNotNil(error, "WebServices succesfully called. Pet not fetched")
            asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }

}
