//
//  NewsFeedResult.swift
//  VKapp
//
//  Created by Валентин Коскин on 06.12.2022.
//

import Foundation

/// third level of request newsfeed
struct NewsFeedResult: Decodable {
    let response: NewsFeedResponse
}
