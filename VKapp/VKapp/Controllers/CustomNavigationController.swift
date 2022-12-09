// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// custom navigation to do custom animation
final class CustomNavigationController: UINavigationController {
    // MARK: Private properties

    private let interactive = CustomInteractiveTransition()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }

    // MARK: Private methods

    private func setDelegate() {
        delegate = self
    }
}

// MARK: UINavigationControllerDelegate

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from _: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            interactive.viewController = toVC
            return CustomPopAnimator()
        case .push:
            if navigationController.viewControllers.first != toVC {
                interactive.viewController = toVC
            }
            return CustomPushAnimator()
        default:
            return nil
        }
    }

    func navigationController(
        _: UINavigationController,
        interactionControllerFor _: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactive.isStarted ? interactive : nil
    }
}
