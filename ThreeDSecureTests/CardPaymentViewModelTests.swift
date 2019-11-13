//
//  CardPaymentViewModelTests.swift
//  ThreeDSecureTests
//
//  Created by Deepesh on 10/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import XCTest
@testable import ThreeDSecure

class CardPaymentViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCardPaymentViewModel_Valid_Card_Details() {

        let cvv = "100"
        let expiryDate = "10/2025"
        let cardNumber = "4242424242424242"

        let cardPaymentViewModel = CardPaymentViewModel(cardNumber: cardNumber,
                                                        expiryDate: expiryDate,
                                                        cvv: cvv)

        XCTAssertTrue(cardPaymentViewModel.isValidated(), "Card details incorrect")
        XCTAssertEqual(cardPaymentViewModel.validateExpiryDate(), .valid, "Expiry Date format is not valid")
        XCTAssertEqual(cardPaymentViewModel.expiryDate, "10/2025", "Expiry Date does not match")
        XCTAssertEqual(cardPaymentViewModel.expiryMonth(), "10", "Expiry Month does not match")
        XCTAssertEqual(cardPaymentViewModel.expiryYear(), "2025", "Expiry Year does not match")

        // test for API Model conversion.
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().cvv, cardPaymentViewModel.cvv, "CVV does not match with API Model")
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().expiry_month, cardPaymentViewModel.expiryMonth(), "Expiry Month does not match with API Model")
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().expiry_year, cardPaymentViewModel.expiryYear(), "Expiry Year does not match with API Model")
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().success_url, "https://success.com", "Default Success URL does not match")
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().failure_url, "https://fail.com", "Default Failure URL does not match")
    }

    func testCardPaymentViewModel_inValid_Card_Details() {

        let cvv = "112345"
        let expiryDate = "100/20250asdf"
        let cardNumber = "42424242424242424242424242424242"

        let cardPaymentViewModel = CardPaymentViewModel(cardNumber: cardNumber,
                                                        expiryDate: expiryDate,
                                                        cvv: cvv)

        XCTAssertFalse(cardPaymentViewModel.isValidated(), "Card details should be incorrect")
        XCTAssertEqual(cardPaymentViewModel.validateExpiryDate(), .invalidInput, "Expiry Date format should be not valid")
        XCTAssertEqual(cardPaymentViewModel.expiryDate, "100/20250asdf", "Expiry Date does not match")
        XCTAssertEqual(cardPaymentViewModel.expiryMonth(), "100", "Expiry Month does not match")
        XCTAssertEqual(cardPaymentViewModel.expiryYear(), "20250asdf", "Expiry Year does not match")

        // test for API Model conversion.
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().cvv, cardPaymentViewModel.cvv, "CVV does not match with API Model")
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().expiry_month, cardPaymentViewModel.expiryMonth(), "Expiry Month does not match with API Model")
        XCTAssertEqual(cardPaymentViewModel.toCardDetails().expiry_year, cardPaymentViewModel.expiryYear(), "Expiry Year does not match with API Model")
    }

    func testCardPaymentViewModel_Expired_Card_Details() {

           let cvv = "100"
           let expiryDate = "10/1989"
           let cardNumber = "4242424242424242"

           let cardPaymentViewModel = CardPaymentViewModel(cardNumber: cardNumber,
                                                           expiryDate: expiryDate,
                                                           cvv: cvv)

           XCTAssertFalse(cardPaymentViewModel.isValidated(), "Card details should be incorrect")
           XCTAssertEqual(cardPaymentViewModel.validateExpiryDate(), .expired, "Expiry Date format should be expired")
           XCTAssertEqual(cardPaymentViewModel.expiryDate, "10/1989", "Expiry Date does not match")
           XCTAssertEqual(cardPaymentViewModel.expiryMonth(), "10", "Expiry Month does not match")
           XCTAssertEqual(cardPaymentViewModel.expiryYear(), "1989", "Expiry Year does not match")

           // test for API Model conversion.
           XCTAssertEqual(cardPaymentViewModel.toCardDetails().cvv, cardPaymentViewModel.cvv, "CVV does not match with API Model")
           XCTAssertEqual(cardPaymentViewModel.toCardDetails().expiry_month, cardPaymentViewModel.expiryMonth(), "Expiry Month does not match with API Model")
           XCTAssertEqual(cardPaymentViewModel.toCardDetails().expiry_year, cardPaymentViewModel.expiryYear(), "Expiry Year does not match with API Model")
           XCTAssertEqual(cardPaymentViewModel.toCardDetails().success_url, "https://success.com", "Default Success URL does not match")
           XCTAssertEqual(cardPaymentViewModel.toCardDetails().failure_url, "https://fail.com", "Default Failure URL does not match")
       }
}
