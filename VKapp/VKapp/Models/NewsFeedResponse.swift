// NewsFeedResponse.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// second level of request newsfeed
struct NewsFeedResponse: Decodable {
    /// array of news
    let news: [NewsFeed]
    /// array of groups
    let groups: [Group]
    /// array of friends
    let friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
    }
}
