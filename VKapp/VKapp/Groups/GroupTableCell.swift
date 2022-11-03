// GroupTableCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Describe one cell in GroupsController with one group
final class GroupTableCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var groupImageView: UIImageView!
    @IBOutlet var groupName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public Methods

    func setCell(upcomingGrpup: Group) {
        groupName.text = upcomingGrpup.name
        groupImageView.image = UIImage(named: upcomingGrpup.imageName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
