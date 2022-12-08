//
//  NewsFeedResult.swift
//  VKapp
//
//  Created by Валентин Коскин on 06.12.2022.
//

import Foundation

/// first level of request newsfeed
struct NewsFeedResult: Decodable {
    /// response 1st level of request
    let response: NewsFeedResponse
}
