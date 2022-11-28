// Photos.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// List of photos
struct Photos: Decodable {
    let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case photos = "sizes"
    }
}
