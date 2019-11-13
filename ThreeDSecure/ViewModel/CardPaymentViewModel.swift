//
//  CardPaymentViewModel.swift
//  ThreeDSecure
//
//  Created by Deepesh on 10/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

enum ExpiryValidation {
    case valid, invalidInput, expired
}

struct CardPaymentViewModel {

    let number: String
    let expiryDate: String
    let cvv: String
    
    init(cardNumber: String,
         expiryDate: String,
         cvv: String) {
        self.number = cardNumber.replacingOccurrences(of: " ", with: "")
        self.expiryDate = expiryDate
        self.cvv = cvv
    }

    func isValidated() -> Bool {

        // validate card number
        if !number.validateCreditCardFormat().valid {
            print("Card number invalid")
            return false
        }

        // validate expiry date
        if validateExpiryDate() == .invalidInput ||
            validateExpiryDate() == .expired {
            print("Expiry date invalid")
            return false
        }

        if expiryMonth().count != 2 {
            print("Expiry month is incorrect")
            return false
        }

        if expiryYear().count != 4 {
            print("Expiry Year is incorrect")
            return false
        }

        if cvv.count != 3 {
            print("CVV is incorrect")
            return false
        }

        return true
    }

    func expiryMonth() -> String {
        let splitDate = expiryDate.components(separatedBy: "/")
        return splitDate.count > 0 ? splitDate[0] : "0"
    }

    func expiryYear() -> String {
        let splitDate = expiryDate.components(separatedBy: "/")
        return splitDate.count > 0 ? splitDate[1] : "0"
    }

    func toCardDetails() -> CardDetails {
        return CardDetails(cardNumber: number,
                           expiry_month: expiryMonth(),
                           expiry_year: expiryYear(),
                           cvv: cvv)
    }

    func validateExpiryDate() -> ExpiryValidation {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"

        guard let enteredDate = dateFormatter.date(from: expiryDate) else {
            return .invalidInput
        }
        let calendar = Calendar.current
        let components = Set([Calendar.Component.month, Calendar.Component.year])
        let currentDateComponents = calendar.dateComponents(components, from: Date())
        let enteredDateComponents = calendar.dateComponents(components, from: enteredDate)

        guard let eYear = enteredDateComponents.year,
            let cYear = currentDateComponents.year, eYear >= cYear else {
            return .expired
        }
        return .valid
    }
}
