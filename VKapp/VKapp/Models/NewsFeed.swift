//
//  NewsFeed.swift
//  VKapp
//
//  Created by Валентин Коскин on 06.12.2022.
//

import Foundation

/// first level of request newsfeed
final class NewsFeed: Decodable {
    var id: Int
    var sourceID: Int
    var text: String
    var authorName: String?
    var avaratPath: String?
    var postImage: String?
    var date: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case sourceID = "source_id"
        case text
        case date
    }
}
