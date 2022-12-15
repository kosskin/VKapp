// FriendTableCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Describe one cell in FriendsController with one friend
final class FriendTableCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var friendNameLabel: UILabel!
    @IBOutlet private var friendShadowView: AvatarView!

    // MARK: - Public Methods

    func configure(upcomingFriend: Friend, photoCacheService: PhotoCacheService) {
        friendNameLabel.text = "\(upcomingFriend.firstName) \(upcomingFriend.lastName)"
        configureImageView()
        friendImageView.image = photoCacheService.photo(byUrl: upcomingFriend.imageName)
    }

    func getFriendImageView() -> UIImageView {
        friendImageView
    }

    // MARK: - Private Methods

    private func configureImageView() {
        friendImageView.layer.masksToBounds = true
        friendImageView.layer.cornerRadius = friendImageView.layer.bounds.width / 2
    }
}
