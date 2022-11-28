// Friend.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// Friend
final class Friend: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var imageName: String

    private enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case imageName = "photo_100"
    }
}
