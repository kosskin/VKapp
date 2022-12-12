// ParseGroupData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Parse data of groups
final class ParseGroupData: Operation {
    // MARK: Public Properties

    var groups: [Group] = []

    // MARK: Public Methods

    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(GroupResult.self, from: data)
            groups = response.response.groups
        } catch {
            print(error.localizedDescription)
        }
    }
}
