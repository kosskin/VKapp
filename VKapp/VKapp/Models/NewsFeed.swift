// NewsFeed.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// third level of request newsfeed
final class NewsFeed: Decodable {
    /// id newsfeed
    let id: Int
    /// id group or user who posts this news
    let sourceID: Int
    /// text if news
    let text: String
    /// date of publication
    let date: Int
    /// author name of this new
    var authorName: String?
    /// path to image avatar
    var avaratPath: String?
    /// path to post image
    var postImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sourceID = "source_id"
        case text
        case date
    }
}
