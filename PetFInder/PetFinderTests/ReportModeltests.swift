//
//  ReportModeltests.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/18/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import XCTest
@testable import PetFinder


class ReportModeltests: XCTestCase {
    //MARK: Initializers
    func testLocationManagerNotNil() {
        // Success case.
        let report = Report()
        XCTAssertNotNil(report.networkManager)
    }
    
    //MARK: Validations
    func testReportEmailValidation(){
        let reportValidEmail = Report()
        reportValidEmail.reporterEmail = "testemail@email.com"
        XCTAssertTrue(reportValidEmail.isValidEmail(), "This is a valid email")
        
        let reportInvalidEmail = Report()
        reportInvalidEmail.reporterEmail = "asdqe23"
        XCTAssertFalse(reportInvalidEmail.isValidEmail(), "This is an invalid email")
    }

}
