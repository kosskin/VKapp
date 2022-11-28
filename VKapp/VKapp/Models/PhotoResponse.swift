// PhotoResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Result of photo response 2nd level
struct PhotoResponse: Decodable {
    let photoResponse: [Photos]

    enum CodingKeys: String, CodingKey {
        case photoResponse = "items"
    }
}
