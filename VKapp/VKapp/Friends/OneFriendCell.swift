// OneFriendCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Describe one cell in OneFriendController
final class OneFriendCell: UICollectionViewCell {
    // MARK: - IBOutlets

    @IBOutlet var photoFriendImageView: UIImageView!

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Public Methods

    func setCell(upcomingImageName: String) {
        photoFriendImageView.image = UIImage(named: upcomingImageName)
    }
}
