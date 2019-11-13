//
//  CardPaymentViewController.swift
//  ThreeDSecure
//
//  Created by Deepesh on 07/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit

class CardPaymentViewController: UIViewController, UITextFieldDelegate {

    private enum Constants {
        static let threeDSecureViewController = "ThreeDSecureViewController"
        static let visa = "visa"
        static let amex = "amex"
        static let none = "none"
    }

    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var expiryDate: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardSchemeIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cardNumber.addTarget(self,
                                  action: #selector(didChangeText(textField:)),
                                  for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cardNumber.becomeFirstResponder()

        cvv.text = ""
        expiryDate.text = ""
        cardNumber.text = ""
        cardSchemeIcon.image = UIImage(named: Constants.none)
    }

    @IBAction func didTapPay(_ sender: Any) {

        guard let cardNumber = cardNumber.text,
            let expiryDate = expiryDate.text,
            let cvv = cvv.text else {
                return
        }

        let cardPaymentViewModel = CardPaymentViewModel(cardNumber: cardNumber,
                                                        expiryDate: expiryDate,
                                                        cvv: cvv)

        if cardPaymentViewModel.isValidated() {
            processPayment(cardDetails: cardPaymentViewModel.toCardDetails())
        } else {
            print("Input data is incorrect please check.")
        }

    }

    private func processPayment(cardDetails: CardDetails) {
        let interactor = CardPaymentInteractor(cardDetails: cardDetails)
        interactor.pay { [weak self] result in
            switch result {
            case .success(let cardPayment):
                print("Success : \(cardPayment.url)")
                //1. redirect to web view with response url.
                DispatchQueue.main.async {
                    let threeDSecureVC = ThreeDSecureViewController(nibName: Constants.threeDSecureViewController, bundle: nil)
                    threeDSecureVC.urlString = cardPayment.url
                    self?.navigationController?.pushViewController(threeDSecureVC, animated: true)
                }
            case .failure(let error):
                print("failed with Error: \(error.localizedDescription)")
            }
        }
    }

    @objc func didChangeText(textField:UITextField) {
        textField.text = self.modifyCreditCardString(creditCardString: textField.text!)

        //set scheme icon
        if cardNumber.text?.validateCreditCardFormat().valid ?? false {
            switch cardNumber.text?.validateCreditCardFormat().type {
            case .Visa:
                cardSchemeIcon.image = UIImage(named: Constants.visa)
            case .Amex:
                cardSchemeIcon.image = UIImage(named: Constants.amex)
            default:
                cardSchemeIcon.image = UIImage(named: Constants.none)
            }
        }
    }

    func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if(arrOfCharacters.count > 0) {
            for i in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[i])
                if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text ?? "").count + string.count - range.length
        if(textField == cardNumber) {
            return newLength <= 19
        }
        return true
    }
}

