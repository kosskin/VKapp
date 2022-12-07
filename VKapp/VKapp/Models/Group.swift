// Group.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Group
@objcMembers
final class Group: Object, Decodable {
    dynamic var nameGroup: String
    dynamic var photo: String
    dynamic var id: Int

    override class func primaryKey() -> String? {
        "nameGroup"
    }

    private enum CodingKeys: String, CodingKey {
        case nameGroup = "name"
        case photo = "photo_100"
        case id
    }
}
