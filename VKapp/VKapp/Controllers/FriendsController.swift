// FriendsController.swift
// Copyright © RoadMap. All rights reserved.

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
        UIImage(named: Constants.friendThreeImageName) ?? UIImage()
    ]

    private let networkService = NetworkService()
    private var friends: Results<Friend>?
    private var friendsSections: [Character: [Friend]] = [:]
    private var friendSectionsTitles: [Character] = []
    private var friendToken: NotificationToken?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriends()
    }

    // MARK: - Public Methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueOneFriendWithSwipeId,
              let oneFriendController = segue.destination as? OneFriendWithSwipeController,
              let currnetId = tableView.indexPathForSelectedRow,
              let friends = friends
        else { return }
        oneFriendController.id = friends[currnetId.row].id
    }

    // DataSource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            if friendsSections[firstLetter] != nil {
                friendsSections[firstLetter]?.append(friend)
            } else {
                friendsSections[firstLetter] = [friend]
            }
        }
        friendSectionsTitles = Array(friendsSections.keys).sorted()
    }

    private func fetchFriends() {
        networkService.fetchFriend(urlString: RequestType.friends.urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(friends):
                self.networkService.saveFriendToRealm(friends)
            case let .failure(error):
                print(error.localizedDescription)
            }
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

    private func loadFriends() {
        do {
            let realm = try Realm()
            let friendsFromRealm = realm.objects(Friend.self)
            addFriendNotificationToken(result: friendsFromRealm)
            if !friendsFromRealm.isEmpty {
                friends = friendsFromRealm
            } else {
                fetchFriends()
            }
        } catch {
            print(error)
        }
    }
}
