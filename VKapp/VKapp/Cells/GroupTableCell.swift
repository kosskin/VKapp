// GroupTableCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Describe one cell in GroupsController with one group
final class GroupTableCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var groupImageView: UIImageView!
    @IBOutlet private var groupName: UILabel!

    // MARK: - Public Methods

    func configure(upcomingGrpup: Group, service: PhotoCacheService) {
        groupName.text = upcomingGrpup.nameGroup
        groupImageView.image = service.photo(byUrl: upcomingGrpup.photo)
        groupImageView.isUserInteractionEnabled = true
        createGestureRecognizer()
    }

    // MARK: Private Methods

    private func createGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func tapAction(_: UITapGestureRecognizer) {
        groupImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(
            withDuration: 1.0,
            delay: 0.2,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 0.9,
            options: [.curveEaseInOut]
        ) {
            self.groupImageView.transform = .identity
        }
    }
}
