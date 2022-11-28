// Friends.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// List of friends
struct Friends: Decodable {
    let friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case friends = "items"
    }
}
