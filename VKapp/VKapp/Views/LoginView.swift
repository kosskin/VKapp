// LoginView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View for login screen
final class LoginView: UIView {
    // MARK: - IBOutlets

    @IBOutlet var enterButton: UIButton!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var enterAppleButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginScrollView: UIScrollView!

    // MARK: - Public Methods

    func addKeyboardEvents() {
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
    }

    func removeKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func hideKeyboardAction() {
        loginScrollView.endEditing(true)
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

    @objc private func keyboardWillHideAction(notification _: Notification) {
        loginScrollView.contentInset = UIEdgeInsets.zero
        loginScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
