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

    // MARK: - IBOutlets

    @IBOutlet private var enterButton: UIButton!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var enterAppleButton: UIButton!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var loginScrollView: UIScrollView!

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShownAction(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboardAction)
        )
        loginScrollView.addGestureRecognizer(tapGesture)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: - Public Methods
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard
            identifier == Constants.segueShowTabBarText,
            let loginText = loginTextField.text,
            let passwordText = passwordTextField.text
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
    
    // MARK: - Private Methods

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary? else { return }
        guard let kbSize = (
            info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey)
                as? NSValue?
        )??.cgRectValue.size else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        loginScrollView.contentInset = contentInset
        loginScrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHideAction(notification: Notification) {
        loginScrollView.contentInset = UIEdgeInsets.zero
        loginScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboardAction() {
        loginScrollView.endEditing(true)
    }
}
