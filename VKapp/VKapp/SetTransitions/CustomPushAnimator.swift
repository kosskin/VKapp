// CustomPushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// for animate transitions between viewControllers (pop)
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Constants

    private enum Constants {
        static let translationDuration = 0.7
        static let shiftLeft: CGFloat = -200
        static let partRelativeDuration = 0.5
        static let scaleTransform: CGFloat = 0.8
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.translationDuration
    }

    func createAnimateKeyFrames(
        transitionContext: UIViewControllerContextTransitioning,
        source: UIViewController,
        destination: UIViewController
    ) {
        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: Constants.partRelativeDuration) {
                let translation = CGAffineTransform(translationX: Constants.shiftLeft, y: 0)
                let scale = CGAffineTransform(scaleX: Constants.scaleTransform, y: Constants.scaleTransform)
                source.view.transform = translation.concatenating(scale)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: Constants.partRelativeDuration) {
                destination.view.transform = .identity
                destination.view.center = source.view.center
            }
        } completion: { finish in
            if finish, !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finish && !transitionContext.transitionWasCancelled)
        }
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(
            translationX: source.view.frame.width / 2 + source.view.frame.height / 2,
            y: -source.view.frame.width / 2
        )

        let rotation = CGAffineTransform(rotationAngle: .pi / -2)

        destination.view.transform = rotation.concatenating(translation)
        destination.view.center = CGPoint(
            x: source.view.bounds.width + source.view.bounds.height / 2,
            y: source.view.bounds.width / 2
        )

        createAnimateKeyFrames(transitionContext: transitionContext, source: source, destination: destination)
    }
}
