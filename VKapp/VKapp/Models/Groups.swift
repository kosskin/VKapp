// Groups.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// List of groups
struct Groups: Decodable {
    let groups: [Group]

    private enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}
