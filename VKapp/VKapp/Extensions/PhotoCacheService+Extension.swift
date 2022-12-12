// PhotoCacheService+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Extenstion for PhotoCacheService
extension PhotoCacheService {
    /// Class to reload Table
    class Table: DataReloadable {
        // MARK: - Public Properties

        let table: UITableView

        // MARK: - Initializers

        init(table: UITableView) {
            self.table = table
        }

        // MARK: - Public Methods

        func reloadRow() {
            table.reloadData()
        }
    }
}
