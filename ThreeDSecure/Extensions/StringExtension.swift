//
//  StringExtension.swift
//  ThreeDSecure
//
//  Created by Deepesh on 10/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

extension String {

    func validateCreditCardFormat()-> (type: CardType, valid: Bool) {

        let numberOnly = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        var type: CardType = .Unknown
        var valid = false

        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }

        // check validity
        valid = numberOnly.luhnCheck()

        return (type, valid)
    }

    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }

    func luhnCheck() -> Bool {
        var sum = 0
        let reversedCharacters = self.reversed().map { String($0) }
        for (idx, element) in reversedCharacters.enumerated() {
            guard let digit = Int(element) else { return false }
            switch ((idx % 2 == 1), digit) {
            case (true, 9): sum += 9
            case (true, 0...8): sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        return sum % 10 == 0
    }
    
}
