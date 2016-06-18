//
//  NetworkManagerTests.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/18/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import XCTest
@testable import PetFinder

class NetworkManagerTests: XCTestCase {

    //MARK: - User calls
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
    
    func testNetworkManagerUpdateReportsNum()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")
        
        let nm = NetworkManager()
        nm.updateReportsNum(["email": "email@test.co", "reports_num": "12"], successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. Reports number updated")
                asyncExpectation.fulfill()
            }) { (error) in
                XCTAssertNotNil(error, "WebServices succesfully called. Reports number not updated")
                asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    //MARK: - Pet calls
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
    
    //MARK: - Report calls
    func testNetworkManagerCreateReport()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")
        
        let nm = NetworkManager()
        let parameters = ["reporter_name": "name",
                          "reporter_cel": "adq",
                          "reporter_observations": "",
                          "reporter_phone": "",
                          "reporter_email": "Email@email.com",
                          "lat": "45.12123",
                          "lon": "-85.3212",
                          "pet_id": "1"]
        
        nm.createReport(parameters, successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. Report created")
                asyncExpectation.fulfill()
            }) { (error) in
                XCTAssertNotNil(error, "WebServices succesfully called. Report not created")
                asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testNetworkManagerListUserReports()
    {
        let asyncExpectation = expectationWithDescription("asynchronous request")
        
        let nm = NetworkManager()
        nm.listUserReports(["email": "emailtest@email.com"], successCallback:
            { (response) in
                XCTAssertNotNil(response, "WebServices succesfully called. Reports listed")
                asyncExpectation.fulfill()
            }) { (error) in
                XCTAssertNotNil(error, "WebServices succesfully called. Reports not listed")
                asyncExpectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
