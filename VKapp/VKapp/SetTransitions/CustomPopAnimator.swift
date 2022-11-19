// CustomPopAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// for animate transitions between viewControllers (push)
final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants

    private enum Constants {
        static let allTimeInterval = 0.7
        static let partTimeInterval = 0.4
        static let startTimeInterval = 0.0
        static let scaleTransform: CGFloat = 0.7
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.allTimeInterval
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)

        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(
            translationX: -source.view.bounds.width, y: 0
        ).concatenating(CGAffineTransform(
            scaleX: Constants.scaleTransform, y: Constants.scaleTransform
        ))
        destination.view.center = CGPoint(
            x: source.view.bounds.width / 2,
            y: source.view.center.y
        )

        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: Constants.startTimeInterval,
                relativeDuration: Constants.partTimeInterval
            ) {
                let translation = CGAffineTransform(translationX: source.view.frame.width, y: 0)
                let scale = CGAffineTransform(rotationAngle: .pi / -2)
                source.view.transform = translation.concatenating(scale)
                source.view.center = CGPoint(
                    x: source.view.bounds.width + source.view.bounds.height / 2,
                    y: source.view.bounds.width / 2
                )
            }
            UIView.addKeyframe(
                withRelativeStartTime: Constants.startTimeInterval,
                relativeDuration: Constants.partTimeInterval
            ) {
                destination.view.transform = .identity
            }
        } completion: { finish in
            if finish, !transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
                transitionContext.completeTransition(true)
            } else {
                transitionContext.completeTransition(false)
            }
        }
    }
}
