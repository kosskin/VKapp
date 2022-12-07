//
//  NewsFeed.swift
//  VKapp
//
//  Created by Валентин Коскин on 06.12.2022.
//

import Foundation

/// third level of request newsfeed
final class NewsFeed: Decodable {
    /// id newsfeed
    var id: Int
    /// id group or user who posts this news
    var sourceID: Int
    /// text if news
    var text: String
    /// author name of this new
    var authorName: String?
    /// path to image avatar
    var avaratPath: String?
    /// path to post image
    var postImage: String?
    /// date of publication
    var date: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case sourceID = "source_id"
        case text
        case date
    }
}
