// OneFriendWithSwipeController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// List of photos one friend with swipe
final class OneFriendWithSwipeController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let xTranslation: CGFloat = 500
        static let halfDuration = 0.5
        static let halfTransform: CGFloat = 0.5
        static let halfOpacity: Float = 0.5
        static let zeroTransform: CGFloat = 0
        static let swipeYTransform: CGFloat = 1000
        static let fullOpacity: Float = 1
        static let differenceIndex = 1
        static let swipeRotatingAngle = CGFloat.pi / 8
        static let scaleTransform: CGFloat = 0.7
    }

    // MARK: - IBOutlets

    @IBOutlet private var photoImageView: UIImageView!

    // MARK: - Public Properties

    var photos: [UIImage?] = []

    // MARK: Private Properties

    private var index = Int()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        createSwipeRecognizer()
    }

    // MARK: Private Methods

    private func configUI() {
        guard let image = photos.first else { return }
        photoImageView.image = image
    }

    private func createSwipeRecognizer() {
        photoImageView.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(doSwipeAction(gesture:)))
        swipeRight.direction = .right
        photoImageView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(doSwipeAction(gesture:)))
        swipeLeft.direction = .left
        photoImageView.addGestureRecognizer(swipeLeft)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(doSwipeAction(gesture:)))
        swipeDown.direction = .down
        photoImageView.addGestureRecognizer(swipeDown)
    }

    private func swipe(translationX: CGFloat, differenceIndex: Int, rotatingAngle: CGFloat) {
        index += differenceIndex
        guard index < photos.count, index >= 0 else {
            index -= differenceIndex
            return
        }
        UIView.animate(withDuration: Constants.halfDuration) {
            let translation = CGAffineTransform(translationX: translationX, y: Constants.zeroTransform)
            let scale = CGAffineTransform(scaleX: Constants.scaleTransform, y: Constants.scaleTransform)
            let rotating = CGAffineTransform(rotationAngle: rotatingAngle)
            self.photoImageView.transform = translation.concatenating(scale).concatenating(rotating)
            self.photoImageView.layer.opacity = Constants.halfOpacity
        } completion: { _ in
            let newPhotoScale = CGAffineTransform(scaleX: Constants.halfTransform, y: Constants.halfTransform)
            self.photoImageView.transform = CGAffineTransform(translationX: -translationX, y: Constants.zeroTransform)
                .concatenating(newPhotoScale)
            UIView.animate(withDuration: Constants.halfDuration) {
                self.photoImageView.layer.opacity = Constants.fullOpacity
                self.photoImageView.transform = .identity
                self.photoImageView.image = self.photos[self.index]
            }
        }
    }

    private func swipeDown() {
        UIView.animate(withDuration: Constants.halfDuration) {
            let translation = CGAffineTransform(translationX: Constants.zeroTransform, y: Constants.swipeYTransform)
            self.photoImageView.transform = translation
        } completion: { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }

    @objc private func doSwipeAction(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            swipe(
                translationX: -Constants.xTranslation,
                differenceIndex: Constants.differenceIndex,
                rotatingAngle: Constants.swipeRotatingAngle
            )
        case .right:
            swipe(
                translationX: Constants.xTranslation,
                differenceIndex: -Constants.differenceIndex,
                rotatingAngle: -Constants.swipeRotatingAngle
            )
        case .down:
            swipeDown()
        default:
            break
        }
    }
}
