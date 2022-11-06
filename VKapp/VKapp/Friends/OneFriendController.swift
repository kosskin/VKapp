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

    var imageName = Constants.emptyString

    // MARK: - Live Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: = Public Methods

    func setData(_ upcomingImageName: String) {
        imageName = upcomingImageName
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        cell.setCell(upcomingImageName: imageName)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
         return true
     }
     */

    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
         return false
     }

     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

     }
     */
}
