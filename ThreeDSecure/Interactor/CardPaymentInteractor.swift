//
//  CardPaymentInteractor.swift
//  ThreeDSecure
//
//  Created by Deepesh on 07/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

class CardPaymentInteractor {

    let cardDetails: CardDetails
    let endPoint = "https://integrations-cko.herokuapp.com/pay"

    init(cardDetails: CardDetails) {
        self.cardDetails = cardDetails
    }
    
    func pay(completion: @escaping (Result<CardPayment, Error>) -> ()) {

        let paymentManager = PaymentServiceManager(endPoint: endPoint,
                                                   cardDetails: cardDetails)
        paymentManager.processCardPayment { result in
            switch result {
            case .success(let cardPayment):
                completion(.success(cardPayment))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
