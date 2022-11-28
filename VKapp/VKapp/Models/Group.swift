// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Group
final class Group: Decodable {
    @objc dynamic var nameGroup: String
    @objc dynamic var photo: String

    private enum CodingKeys: String, CodingKey {
        case nameGroup = "name"
        case photo = "photo_100"
    }
}
