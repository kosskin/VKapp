// LoginWebViewViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// screen with enter in VK
final class LoginWebViewViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let urlPath = "/blank.html"
        static let ampersant = "&"
        static let equals = "="
        static let accessTokenName = "access_token"
        static let userIdName = "user_id"
        static let segueTabBarId = "showNavTabBar"
    }

    // MARK: - IBOutlets

    @IBOutlet private var vkWebView: WKWebView! {
        didSet {
            vkWebView.navigationDelegate = self
        }
    }

    // MARK: - Private Properties

    private let vkAPISevice = VKAPIService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        webViewLoad()
    }

    // MARK: - Private Methods

    private func webViewLoad() {
        guard let url = vkAPISevice.createURLToLoadWebView() else { return }
        let request = URLRequest(url: url)
        vkWebView.load(request)
    }
}

// MARK: - WKNavigationDelegate

extension LoginWebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        guard let url = navigationResponse.response.url,
              url.path == Constants.urlPath,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: Constants.ampersant)
            .map { $0.components(separatedBy: Constants.equals) }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params[Constants.accessTokenName],
              let userID = params[Constants.userIdName]
        else {
            decisionHandler(.allow)
            return
        }

        Session.shared.token = token
        Session.shared.userID = userID

        performSegue(withIdentifier: Constants.segueTabBarId, sender: self)
        decisionHandler(.cancel)
    }
}
