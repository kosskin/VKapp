// LoginView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View for login screen
final class LoginView: UIView {
    // MARK: - IBOutlets

    @IBOutlet private var enterButton: UIButton!
    @IBOutlet private var enterAppleButton: UIButton!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet var loginScrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    // MARK: - Public Methods

    @objc func hideKeyboardAction() {
        loginScrollView.endEditing(true)
    }

    // MARK: - Private Methods

    private func addKeyboardEvents() {
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

    private func removeKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc private func keyboardWillShownAction(notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let kbSize = (
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
