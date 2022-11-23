// LoginWebViewViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// screen with enter in VK
final class LoginWebViewViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let path = "/authorize"
        static let urlQueryItemClientName = "client_id"
        static let urlQueryItemClientValue = "51484462"
        static let urlQueryItemDisplayName = "display"
        static let urlQueryItemDisplayValue = "mobile"
        static let urlQueryItemRedirectUriName = "redirect_uri"
        static let urlQueryItemRedirectUriValue = "https://oauth.vk.com/blank.html"
        static let urlQueryItemScopeName = "scope"
        static let urlQueryItemScopeValue = "262150"
        static let urlQueryItemResponseTypeName = "response_type"
        static let urlQueryItemResponseTypeValue = "token"
        static let urlQueryItemVName = "v"
        static let urlQueryItemVValue = "5.131"
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

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        webViewLoad()
    }

    // MARK: - Private Methods

    private func webViewLoad() {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.urlQueryItemClientName, value: Constants.urlQueryItemClientValue),
            URLQueryItem(name: Constants.urlQueryItemDisplayName, value: Constants.urlQueryItemDisplayValue),
            URLQueryItem(name: Constants.urlQueryItemRedirectUriName, value: Constants.urlQueryItemRedirectUriValue),
            URLQueryItem(name: Constants.urlQueryItemScopeName, value: Constants.urlQueryItemScopeValue),
            URLQueryItem(name: Constants.urlQueryItemResponseTypeName, value: Constants.urlQueryItemResponseTypeValue),
            URLQueryItem(name: Constants.urlQueryItemVName, value: Constants.urlQueryItemVValue)
        ]

        guard let url = urlComponents.url else { return }
        print(url)
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
              let userId = params[Constants.userIdName]
        else {
            decisionHandler(.allow)
            return
        }

        Session.shared.token = token
        Session.shared.userId = userId

        performSegue(withIdentifier: Constants.segueTabBarId, sender: self)
        decisionHandler(.cancel)
    }
}
