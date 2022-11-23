// Session.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// information about user session(token and userID)
final class Session {
    // MARK: - Public Properties

    static let shared = Session()
    var token = ""
    var userID = ""

    // MARK: - Initializers

    private init() {}
}
