//
//  APIServiceManager.swift
//  ThreeDSecure
//
//  Created by Deepesh on 07/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import Foundation

class PaymentServiceManager {

    var endPoint: String
    var cardDetails: CardDetails

    init(endPoint: String, cardDetails: CardDetails) {
        self.endPoint = endPoint
        self.cardDetails = cardDetails
    }

    func processCardPayment(completion: @escaping (Result<CardPayment, Error>) -> ()) {

        guard let url = URL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            urlRequest.httpBody = try JSONEncoder().encode(cardDetails)
        } catch {
            print(error)
        }

        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let data = data else {
                print("Error: did not receive data")
                return
            }

            do {
                let response = try JSONDecoder().decode(CardPayment.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }

        }
        task.resume()
    }

}
