// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Result of group response
struct PhotoResult: Decodable {
    let response: PhotoResponse
}

/// Result of photo response 2nd level
struct PhotoResponse: Decodable {
    let photoResponse: [Photos]

    enum CodingKeys: String, CodingKey {
        case photoResponse = "items"
    }
}

/// List of photos
struct Photos: Decodable {
    let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case photos = "sizes"
    }
}

/// One Photo
final class Photo: Decodable {
    @objc dynamic var url: String
}
