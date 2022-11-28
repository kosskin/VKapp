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

    func setCell(upcomingFriend: Friend, service: NetworkService) {
        friendNameLabel.text = "\(upcomingFriend.firstName) \(upcomingFriend.lastName)"
        friendImageView.loadImage(imageURL: upcomingFriend.imageName, service: service)

        friendImageView.layer.masksToBounds = true
        friendImageView.layer.cornerRadius = friendImageView.layer.bounds.width / 2
    }

    func getFriendImageView() -> UIImageView {
        friendImageView
    }
}
