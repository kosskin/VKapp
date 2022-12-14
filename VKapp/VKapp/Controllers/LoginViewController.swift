// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

//  VKapp
//
//  Created by Валентин Коскин on 31.10.2022.
//
import UIKit

/// User input screen
final class LoginViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let errorTitleText = "Error"
        static let errorMessageText = "Not right login/password"
        static let loginText = "admin"
        static let passwordText = "12345"
        static let segueShowTabBarText = "showTabBar"
    }

    // MARK: - Private Properties

    private lazy var contentView = self.view as? LoginView

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(contentView?.hideKeyboardAction)
        )
        contentView?.loginScrollView.addGestureRecognizer(tapGesture)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - Public Methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender _: Any?) -> Bool {
        guard
            identifier == Constants.segueShowTabBarText,
            let loginText = contentView?.loginTextField.text,
            let passwordText = contentView?.passwordTextField.text
        else {
            return false
        }

        if loginText == Constants.loginText, passwordText == Constants.passwordText {
            return true
        } else {
            showErrorAlert(title: Constants.errorTitleText, message: Constants.errorMessageText)
            return false
        }
    }
}
