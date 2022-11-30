// Photo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

/// One Photo
@objcMembers
final class Photo: Object, Decodable {
    dynamic var url: String
}
