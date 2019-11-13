//
//  PaymentResultViewController.swift
//  ThreeDSecure
//
//  Created by Deepesh on 09/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit

enum PaymentResult {
    case success
    case failure
}

class PaymentResultViewController: UIViewController {

    private enum Constants {
        static let paymentCompleted = "Payment Completed :)"
        static let paymentFailed = "Payment Failed :("
        static let startNewTransaction = "Start New Transaction"
        static let retry = "Try Again"
    }

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    var result: PaymentResult?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)

        switch result {
        case .success:
            resultLabel.text = Constants.paymentCompleted
            actionButton.setTitle(Constants.startNewTransaction, for: .normal)
        case .failure:
            resultLabel.text = Constants.paymentFailed
            actionButton.setTitle(Constants.retry, for: .normal)
        case .none:
            break
        }
    }

    @IBAction func didTapAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
