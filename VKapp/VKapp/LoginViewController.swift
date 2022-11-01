// LoginViewController.swift
// Copyright © RoadMap. All rights reserved.

//
//  ViewController.swift
//  VKapp
//
//  Created by Валентин Коскин on 31.10.2022.
//
import UIKit

/// Main ViewController
final class LoginViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let alertTitleText = "Error"
        static let alertMessageText = "Not right login/password"
        static let okText = "Ok"
        static let loginText = "admin"
        static let passwordText = "12345"
        static let segueShowTabBarText = "showTabBar"
    }

    // MARK: IBOutlets

    @IBOutlet private var enterButton: UIButton!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var enterAppleButton: UIButton!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var loginScrollView: UIScrollView!

    // MARK: Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        loginScrollView.addGestureRecognizer(tapGesture)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: Private Methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constants.segueShowTabBarText {
            guard let loginText = loginTextField.text else { return false }
            guard let passwordText = passwordTextField.text else { return false }
            if loginText == Constants.loginText, passwordText == Constants.passwordText {
                return true
            } else {
                showErrorAlert()
                return false
            }
        }
        return false
    }

    @objc private func keyboardWillShown(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary? else { return }
        guard let kbSize = (
            info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey)
                as? NSValue?
        )??.cgRectValue.size else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        loginScrollView.contentInset = contentInset
        loginScrollView.scrollIndicatorInsets = contentInset
    }

    @objc private func keyboardWillHide(notification: Notification) {
        loginScrollView.contentInset = UIEdgeInsets.zero
        loginScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboard() {
        loginScrollView.endEditing(true)
    }

    private func showErrorAlert() {
        let alert = UIAlertController(
            title: Constants.alertTitleText,
            message: Constants.alertMessageText,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: Constants.okText, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
