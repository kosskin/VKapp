// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// One Photo
@objcMembers
final class Photo: Object, Decodable {
    /// URL of photo
    dynamic var url: String
    /// Height of photo
    dynamic var height: Int
    /// Width of photo
    dynamic var width: Int
    /// AspectRatio of photo
    dynamic var aspectRatio: CGFloat { CGFloat(height) / CGFloat(width) }
}
