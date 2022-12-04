// Photos.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// List of photos
final class Photos: Object, Decodable {
    @Persisted var photos = List<Photo>()
    @Persisted(primaryKey: true) var id: Int
    @Persisted var ownerId: Int

    private enum CodingKeys: String, CodingKey {
        case photos = "sizes"
        case id
        case ownerId = "owner_id"
    }
}
