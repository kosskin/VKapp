// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Result of group response
struct GroupResult: Decodable {
    let response: Groups
}

/// List of groups
struct Groups: Decodable {
    let groups: [Group]

    private enum CodingKeys: String, CodingKey {
        case groups = "items"
    }
}

/// Group
final class Group: Decodable {
    @objc dynamic var nameGroup: String
    @objc dynamic var photo: String

    private enum CodingKeys: String, CodingKey {
        case nameGroup = "name"
        case photo = "photo_100"
    }
}
