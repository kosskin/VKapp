//
//  NewsFeedResponse.swift
//  VKapp
//
//  Created by Валентин Коскин on 06.12.2022.
//

import Foundation

/// second level of request newsfeed
struct NewsFeedResponse: Decodable {
    let news: [NewsFeed]
    let groups: [Group]
    let friends: [Friend]
    
    enum CodingKeys: String, CodingKey {
        case news = "items"
        case friends = "profiles"
        case groups
    }
}
