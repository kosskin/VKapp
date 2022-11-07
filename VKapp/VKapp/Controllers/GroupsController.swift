// GroupsController.swift
// Copyright © RoadMap. All rights reserved.

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

    private var groups = [
        Group(name: Constants.groupOneName, imageName: Constants.groupOneImageName),
        Group(name: Constants.groupTwoName, imageName: Constants.groupTwoImageName),
        Group(name: Constants.groupThreeName, imageName: Constants.groupThreeImageName),
        Group(name: Constants.groupFourName, imageName: Constants.groupFourImageName),
        Group(name: Constants.groupFiveName, imageName: Constants.groupFiveImageName),
        Group(name: Constants.groupSixName, imageName: Constants.groupSixImageName),
        Group(name: Constants.groupSevenName, imageName: Constants.groupSevenImageName),
        Group(name: Constants.groupEightName, imageName: Constants.groupEightImageName)
    ]

    // MARK: - IBActions

    @IBAction private func addGroupAction(segue: UIStoryboardSegue) {
        guard segue.identifier == Constants.segueId else { return }
        guard let newGroupsController = segue.source as? NewGroupsController else { return }
        guard let indexPath = newGroupsController.tableView.indexPathForSelectedRow else { return }
        let group = newGroupsController.newGroups[indexPath.row]
        guard !groups.contains(group) else { return }
        groups.append(group)
        newGroupsController.newGroups.remove(at: indexPath.row)
        newGroupsController.tableView.reloadData()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.groupCellIdText, for: indexPath) as? GroupTableCell
        else { return UITableViewCell() }
        cell.setCell(upcomingGrpup: groups[indexPath.row])
        return cell
    }
}
