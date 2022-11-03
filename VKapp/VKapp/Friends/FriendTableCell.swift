// FriendTableCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Describe one cell in FriendsController with one friend
final class FriendTableCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var friendImageView: UIImageView!
    @IBOutlet private var friendNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Public Methods

    func setCell(upcomingFriend: User) {
        friendNameLabel.text = upcomingFriend.name
        friendImageView.image = UIImage(named: upcomingFriend.imageName)
    }
}
