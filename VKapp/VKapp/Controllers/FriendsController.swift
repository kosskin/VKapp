// FriendsController.swift
// Copyright © RoadMap. All rights reserved.

import PromiseKit
import RealmSwift
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
        static let segueOneFriendWithSwipeId = "oneFriendSegueWithSwipe"
    }

    // MARK: - Private Properties

    private let imagesForSwipe: [UIImage] = [
        UIImage(named: Constants.friendOneImageName) ?? UIImage(),
        UIImage(named: Constants.friendTwoImageName) ?? UIImage(),
        UIImage(named: Constants.friendThreeImageName) ?? UIImage(),
    ]

    private let networkServicePromise = NetworkServicePromise()
    private let networkService = NetworkService()
    private var friends: Results<Friend>?
    private var friendsSectionsMap: [Character: [Friend]] = [:]
    private var friendSectionsTitles: [Character] = []
    private var friendToken: NotificationToken?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        guard segue.identifier == Constants.segueOneFriendWithSwipeId,
              let oneFriendController = segue.destination as? OneFriendWithSwipeController,
              let currnetId = tableView.indexPathForSelectedRow,
              let friends = friends
        else { return }
        oneFriendController.id = friends[currnetId.row].id
    }

    // DataSource methods

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        friends?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.friendCellIdText, for: indexPath) as? FriendTableCell,
            let friends = friends
        else { return UITableViewCell() }
        let friend = friends[indexPath.row]
        cell.setCell(upcomingFriend: friend, service: networkService)
        return cell
    }

    // MARK: - Private Methods

    private func createFriendSections() {
        guard let friends = friends else { return }
        for friend in friends {
            guard let firstLetter = friend.firstName.first else { return }
            if friendsSectionsMap[firstLetter] != nil {
                friendsSectionsMap[firstLetter]?.append(friend)
            } else {
                friendsSectionsMap[firstLetter] = [friend]
            }
        }
        friendSectionsTitles = Array(friendsSectionsMap.keys).sorted()
    }

    private func fetchFriends() {
        firstly {
            networkServicePromise.fetchFriends(urlSting: RequestType.friends.urlString)
        }.done { friends in
            RealmService.save(items: friends)
        }.catch { error in
            print(error.localizedDescription)
        }
    }

    private func addFriendNotificationToken(result: Results<Friend>) {
        friendToken = result.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update:
                self?.friends = result
                self?.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func loadData() {
        let dataFromRealm = RealmService.get(Friend.self)
        guard let friendsFromRealm = dataFromRealm else { return }
        addFriendNotificationToken(result: friendsFromRealm)
        if !friendsFromRealm.isEmpty {
            friends = friendsFromRealm
        } else {
            fetchFriends()
        }
    }
}
