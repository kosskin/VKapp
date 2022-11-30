// GroupsController.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift
import UIKit

/// List of groups screen
final class GroupsController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let groupCellIdText = "groupCell"
        static let groupOneName = "Fans of Vladimir Putin"
        static let groupOneImageName = "putin"
        static let groupTwoName = "Fans of Joe Baiden"
        static let groupTwoImageName = "baiden"
        static let groupThreeName = "Fans of Kim Chen In"
        static let groupThreeImageName = "kim"
        static let groupFourName = "Fans of Cristiano Ronaldo"
        static let groupFourImageName = "ronaldo"
        static let groupFiveName = "Fans of Leonel Messi"
        static let groupFiveImageName = "messi"
        static let groupSixName = "Fans of Steve Jobs"
        static let groupSixImageName = "jobs"
        static let groupSevenName = "Fans of Ilon Mask"
        static let groupSevenImageName = "mask"
        static let groupEightName = "Fans of Peskov"
        static let groupEightImageName = "peskov"
        static let segueId = "addGroup"
    }

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var groups: Results<Group>?
    private var groupToken: NotificationToken?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGroups()
    }

    // MARK: - Private Methods

    private func fetchGroups() {
        networkService.fetchGroup(urlString: RequestType.groups.urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(groups):
                self.networkService.saveGroupToRealm(groups)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func addGroupNotificationToken(result: Results<Group>) {
        groupToken = result.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update:
                self?.groups = result
                self?.tableView.reloadData()
            case let .error(error):
                print(error.localizedDescription)
            }
        }
    }

    private func loadGroups() {
        do {
            let realm = try Realm()
            let groupsFromRealm = realm.objects(Group.self)
            addGroupNotificationToken(result: groupsFromRealm)
            if !groupsFromRealm.isEmpty {
                groups = groupsFromRealm
            } else {
                fetchGroups()
            }
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.groupCellIdText, for: indexPath) as? GroupTableCell
        else { return UITableViewCell() }
        cell.setCell(upcomingGrpup: groups?[indexPath.row] ?? Group(), service: networkService)
        return cell
    }
}
