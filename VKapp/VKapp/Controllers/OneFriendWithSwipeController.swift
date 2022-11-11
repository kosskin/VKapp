// OneFriendWithSwipeController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// List of photos one friend with swipe
final class OneFriendWithSwipeController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let xTranslation: CGFloat = 500
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
        UIView.animate(withDuration: 0.5) {
            let translation = CGAffineTransform(translationX: translationX, y: 0)
            let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
            let rotating = CGAffineTransform(rotationAngle: rotatingAngle)
            self.photoImageView.transform = translation.concatenating(scale).concatenating(rotating)
            self.photoImageView.layer.opacity = 0.5
        } completion: { _ in
            let newPhotoScale = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.photoImageView.transform = CGAffineTransform(translationX: -translationX, y: 0)
                .concatenating(newPhotoScale)
            UIView.animate(withDuration: 0.5) {
                self.photoImageView.layer.opacity = 1
                self.photoImageView.transform = .identity
                self.photoImageView.image = self.photos[self.index]
            }
        }
    }

    private func swipeDown() {
        UIView.animate(withDuration: 0.5) {
            let translation = CGAffineTransform(translationX: 0, y: 1000)
            self.photoImageView.transform = translation
        } completion: { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }

    @objc private func doSwipeAction(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            swipe(translationX: -Constants.xTranslation, differenceIndex: 1, rotatingAngle: CGFloat.pi / 8)
        case .right:
            swipe(translationX: Constants.xTranslation, differenceIndex: -1, rotatingAngle: -CGFloat.pi / 6)
        case .down:
            swipeDown()
        default:
            break
        }
    }
}
