// DataReloadable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Method for reload cells
protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}
