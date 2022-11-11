// CustomInteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// interaction animation
final class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: Constants

    private enum Constants {
        static let progressStatus: CGFloat = 0.33
    }

    // MARK: Public Properties

    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlerAction(sender:)))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var isStarted = false

    // MARK: Private properties

    private var isFinish = false

    // MARK: Private methods

    @objc private func handlerAction(sender: UIScreenEdgePanGestureRecognizer) {
        switch sender.state {
        case .began:
            isStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = sender.translation(in: sender.view)
            let relative = translation.y / (sender.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relative))
            isFinish = progress > Constants.progressStatus
            update(progress)
        case .ended:
            isStarted = false
            if isFinish {
                finish()
            } else {
                cancel()
            }
        case .cancelled:
            isStarted = false
            cancel()
        default:
            return
        }
    }
}
