// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// extension for unuversal alert
extension LoginViewController {
    // MARK: - Constants

    private enum Constants {
        static let alertActionTitleText = "Ok"
    }

    // MARK: - Private Methods

    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: Constants.alertActionTitleText, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
