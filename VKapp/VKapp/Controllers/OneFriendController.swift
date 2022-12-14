// OneFriendController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// List of photos one friend
final class OneFriendController: UICollectionViewController {
    // MARK: - Constants

    private enum Constants {
        static let oneFriendCellId = "oneFriendCell"
        static let emptyString = ""
    }

    // MARK: - Private Properties

    private var imageName = Constants.emptyString

    // MARK: - Public Methods

    func setData(_ upcomingImageName: String) {
        imageName = upcomingImageName
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        30
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.oneFriendCellId,
            for: indexPath
        ) as? OneFriendCell else { return UICollectionViewCell() }
        cell.configure(upcomingImageName: imageName)
        return cell
    }
}
