// FriendsController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// List of friends screen
final class FriendsController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendCellIdText = "friendCell"
        static let friendOneName = "Vladimir Putin"
        static let friendOneImageName = "putin"
        static let friendTwoName = "Joe Baiden"
        static let friendTwoImageName = "baiden"
        static let friendThreeName = "Kim Chen In"
        static let friendThreeImageName = "kim"
        static let friendFourName = "Cristiano Ronaldo"
        static let friendFourImageName = "ronaldo"
        static let friendFiveName = "Leonel Messi"
        static let friendFiveImageName = "messi"
        static let friendSixName = "Steve Jobs"
        static let friendSixImageName = "jobs"
        static let friendSevenName = "Ilon Mask"
        static let friendSevenImageName = "mask"
        static let friendEightName = "Peskov"
        static let friendEightImageName = "peskov"
        static let segueOneFriendId = "oneFriendSegue"
    }

    // MARK: - Private Properties

    private var friends = [
        User(name: Constants.friendOneName, imageName: Constants.friendOneImageName),
        User(name: Constants.friendTwoName, imageName: Constants.friendTwoImageName),
        User(name: Constants.friendThreeName, imageName: Constants.friendThreeImageName),
        User(name: Constants.friendFourName, imageName: Constants.friendFourImageName),
        User(name: Constants.friendFiveName, imageName: Constants.friendFiveImageName),
        User(name: Constants.friendSixName, imageName: Constants.friendSixImageName),
        User(name: Constants.friendSevenName, imageName: Constants.friendSevenImageName),
        User(name: Constants.friendEightName, imageName: Constants.friendEightImageName)
    ]

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueOneFriendId,
              let oneFriendController = segue.destination as? OneFriendController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let friendImageName = friends[indexPath.row].imageName
        oneFriendController.setData(friendImageName)
    }

    // MARK: - TableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.friendCellIdText, for: indexPath) as? FriendTableCell
        else { return UITableViewCell() }
        cell.setCell(upcomingFriend: friends[indexPath.row])
        return cell
    }
}
