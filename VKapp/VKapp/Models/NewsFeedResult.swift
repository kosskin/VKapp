// NewsFeedResult.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// first level of request newsfeed
struct NewsFeedResult: Decodable {
    /// response 1st level of request
    let response: NewsFeedResponse
}
