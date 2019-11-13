//
//  StringExtensionTests.swift
//  ThreeDSecureTests
//
//  Created by Deepesh on 11/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import XCTest
@testable import ThreeDSecure

class StringExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testValidateCreditCardFormat() {

        // Visa
        XCTAssertEqual("4242424242424242".validateCreditCardFormat().type, .Visa, "Card Type does not match")
        XCTAssertTrue("4242424242424242".validateCreditCardFormat().valid, "Card Type does not match")

        // Amex
        XCTAssertEqual("340000000000009".validateCreditCardFormat().type, .Amex, "Card Type does not match")
        XCTAssertTrue("340000000000009".validateCreditCardFormat().valid, "Card Type does not match")

        // Diners Club
        XCTAssertEqual("30000000000004".validateCreditCardFormat().type, .Diners, "Card Type does not match")
        XCTAssertTrue("30000000000004".validateCreditCardFormat().valid, "Card Type does not match")

        // Diners Club
        XCTAssertEqual("30000000000004".validateCreditCardFormat().type, .Diners, "Card Type does not match")
        XCTAssertTrue("30000000000004".validateCreditCardFormat().valid, "Card Type does not match")

        // MasterCard
        XCTAssertEqual("5500000000000004".validateCreditCardFormat().type, .MasterCard, "Card Type does not match")
        XCTAssertTrue("5500000000000004".validateCreditCardFormat().valid, "Card Type does not match")

        // JCB
        XCTAssertEqual("3530111333300000".validateCreditCardFormat().type, .JCB, "Card Type does not match")
        XCTAssertTrue("3530111333300000".validateCreditCardFormat().valid, "Card Type does not match")

        // UNknown
        XCTAssertEqual("8783530111333300000".validateCreditCardFormat().type, .Unknown, "Card Type does not match")
        XCTAssertFalse("8783530111333300000".validateCreditCardFormat().valid, "Card format should be incorrect")

    }

}
