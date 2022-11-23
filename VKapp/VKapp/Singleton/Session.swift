// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Save user information(token and userID)
final class Session {
    // MARK: - Public Properties

    static let shared = Session()
    var token = ""
    var userId = ""

    // MARK: - Initializers

    private init() {}
}
