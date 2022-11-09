// NewGroupsController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// List of new groups for user screen
final class NewGroupsController: UITableViewController {
    // MARK: - Constants

    private enum Constants {
        static let newGroupCellIdText = "newGroupCell"
        static let newGroupOneName = "Fans of Bolt"
        static let newGroupOneImageName = "bolt"
        static let newGroupTwoName = "Fans of Maria Sharapova"
        static let newGroupTwoImageName = "sharapova"
        static let newGroupThreeName = "Fans of Mbape"
        static let newGroupThreeImageName = "mbape"
        static let newGroupFourName = "Fans of Neymar"
        static let newGroupFourImageName = "neymar"
    }

    // MARK: IBOutlets

    @IBOutlet private var groupSearchBar: UISearchBar!

    // MARK: - Public Properties

    var newGroups = [
        Group(name: Constants.newGroupOneName, imageName: Constants.newGroupOneImageName),
        Group(name: Constants.newGroupTwoName, imageName: Constants.newGroupTwoImageName),
        Group(name: Constants.newGroupThreeName, imageName: Constants.newGroupThreeImageName),
        Group(name: Constants.newGroupFourName, imageName: Constants.newGroupFourImageName)
    ]

    // MARK: - Private Properties

    private var searchBackUpList: [Group]?

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.newGroupCellIdText,
            for: indexPath
        ) as? GroupTableCell else { return UITableViewCell() }
        cell.setCell(upcomingGrpup: newGroups[indexPath.row])
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension NewGroupsController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBackUpList = newGroups
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        newGroups = searchBackUpList ?? []
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        newGroups = searchBackUpList ?? []
        if !searchText.isEmpty {
            newGroups = newGroups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}
