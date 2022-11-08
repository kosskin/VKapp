// FriendsController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// List of friends screen
final class FriendsController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let friendCellIdText = "friendCell"
        static let friendOneName = "Putin Vladimir"
        static let friendOneImageName = "putin"
        static let friendTwoName = "Baiden Joe"
        static let friendTwoImageName = "baiden"
        static let friendThreeName = "Kim Chen In"
        static let friendThreeImageName = "kim"
        static let friendFourName = "Ronaldo Cristiano"
        static let friendFourImageName = "ronaldo"
        static let friendFiveName = "Messi Lionel"
        static let friendFiveImageName = "messi"
        static let friendSixName = "Jobs Steve"
        static let friendSixImageName = "jobs"
        static let friendSevenName = "Mask Ilon"
        static let friendSevenImageName = "mask"
        static let friendEightName = "Peskov hzKakEgo"
        static let friendEightImageName = "peskov"
        static let segueOneFriendId = "oneFriendSegue"
        static let backgroundColorName = "backgroundColor"
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

    private var friendsSections: [Character: [User]] = [:]
    private var friendSectionsTitles: [Character] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createFriendSections()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueOneFriendId,
              let oneFriendController = segue.destination as? OneFriendController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let friendImageName = friends[indexPath.row].imageName
        oneFriendController.setData(friendImageName)
    }

    // MARK: - Private Methods

    private func createFriendSections() {
        for friend in friends {
            guard let firstLetter = friend.name.first else { return }
            if friendsSections[firstLetter] != nil {
                friendsSections[firstLetter]?.append(friend)
            } else {
                friendsSections[firstLetter] = [friend]
            }
        }
        friendSectionsTitles = Array(friendsSections.keys).sorted()
    }

    // MARK: - TableView DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        friendsSections.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        friendSectionsTitles.map { String($0) }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(friendSectionsTitles[section])
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let viewHeader = (view as? UITableViewHeaderFooterView) else { return }
        viewHeader.contentView.backgroundColor = UIColor(named: Constants.backgroundColorName)
        viewHeader.contentView.alpha = 0.5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendsSections[friendSectionsTitles[section]]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.friendCellIdText, for: indexPath) as? FriendTableCell,
            let friend = friendsSections[friendSectionsTitles[indexPath.section]]?[indexPath.row]
        else { return UITableViewCell() }
        cell.setCell(upcomingFriend: friend)
        return cell
    }
}
