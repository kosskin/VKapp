// GroupTableCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Describe one cell in GroupsController with one group
final class GroupTableCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupName: UILabel!

    // MARK: - Public Methods

    func setCell(upcomingGrpup: Group) {
        groupName.text = upcomingGrpup.name
        groupImageView.image = UIImage(named: upcomingGrpup.imageName)
    }
}
