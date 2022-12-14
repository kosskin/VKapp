// OneFriendCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Describe one cell in OneFriendController
final class OneFriendCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var photoFriendImageView: UIImageView!

    // MARK: - Public Methods

    func configureCell(upcomingImageName: String) {
        photoFriendImageView.image = UIImage(named: upcomingImageName)
    }
}
