//
//  CardDetails.swift
//  ThreeDSecure
//
//  Created by Deepesh on 09/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

struct CardDetails : Encodable {

    let number: String
    let expiry_month: String
    let expiry_year: String
    let cvv: String

    // default hardcoded urls
    let success_url: String = "https://success.com"
    let failure_url: String = "https://fail.com"

    init(cardNumber: String,
         expiry_month: String,
         expiry_year: String,
         cvv: String) {
        self.number = cardNumber
        self.expiry_month = expiry_month
        self.expiry_year = expiry_year
        self.cvv = cvv
    }
}
