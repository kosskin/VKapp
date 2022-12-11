// ReloadTable.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Describe operation save to realm after parsing
final class ReloadTable: Operation {
    // MARK: - Public Methods

    override func main() {
        guard let getParseData = dependencies.first as? ParseGroupData else { return }
        let parseData = getParseData.groups
        RealmService.save(items: parseData)
    }
}
