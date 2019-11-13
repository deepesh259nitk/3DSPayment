//
//  ThreeDSecureViewController.swift
//  ThreeDSecure
//
//  Created by Deepesh on 09/11/2019.
//  Copyright © 2019 Freelancer. All rights reserved.
//

import UIKit
import WebKit

class ThreeDSecureViewController: UIViewController, WKNavigationDelegate {

    private enum Constants {
        static let success = "success"
        static let fail = "fail"
        static let paymentResultViewController = "PaymentResultViewController"
    }

    @IBOutlet weak var webView: WKWebView!
    var urlString: String?

    // counter for couting redirection urls
    static var redirectCount = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)

        guard let urlString = urlString,
            let url = URL(string: urlString) else {
            return
        }

        //reset the counter to 1 for every view did load
        ThreeDSecureViewController.redirectCount = 1
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
        webView.navigationDelegate = self
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }

        if url.absoluteString.contains(Constants.success) &&
            ThreeDSecureViewController.redirectCount == 1  {
            ThreeDSecureViewController.redirectCount += 1
            let resultVC = PaymentResultViewController(nibName: Constants.paymentResultViewController, bundle: nil)
            resultVC.result = .success
            self.navigationController?.pushViewController(resultVC, animated: true)
        } else if url.absoluteString.contains(Constants.fail) &&
            ThreeDSecureViewController.redirectCount == 1  {
            let resultVC = PaymentResultViewController(nibName: Constants.paymentResultViewController, bundle: nil)
            resultVC.result = .failure
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        decisionHandler(.allow)
    }

}
