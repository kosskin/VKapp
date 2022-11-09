// LikesControl.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// View with custom Likes Control
final class LikesControl: UIControl {
    // MARK: - Constants

    private enum Constants {
        static let heartImageName = "suit.heart"
        static let fillHeartImageName = "suit.heart.fill"
    }

    // MARK: - IBOutlets

    @IBOutlet private var countLikesLabel: UILabel!
    @IBOutlet private var heartImageView: UIImageView!

    // MARK: - Private Properties

    private var isLiked = false
    private var likesCount = 0

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        createGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createGestureRecognizer()
    }

    // MARK: - Private Methods

    private func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func tapAction(_: UITapGestureRecognizer) {
        isLiked.toggle()

        guard isLiked else {
            likesCount -= 1
            heartImageView.image = UIImage(systemName: Constants.heartImageName)
            heartImageView.tintColor = .lightGray
            countLikesLabel.text = String(likesCount)
            countLikesLabel.textColor = .lightGray
            UIView.animate(withDuration: 0.5) {
                self.heartImageView.transform = CGAffineTransform(rotationAngle: 0.0)
            }
            return
        }

        likesCount += 1
        heartImageView.image = UIImage(systemName: Constants.fillHeartImageName)
        heartImageView.tintColor = .systemRed
        countLikesLabel.text = String(likesCount)
        countLikesLabel.textColor = .systemRed
        UIView.animate(withDuration: 0.5) {
            self.heartImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
        countLikesLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(
            withDuration: 1.0,
            delay: 0.2,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.7,
            options: [.curveEaseIn]
        ) {
            self.countLikesLabel.transform = .identity
        } completion: { _ in
        }
    }
}
