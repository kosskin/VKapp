// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Describe types of news
enum NewsType {
    case text
    case photo
}

/// Describe one news
struct News {
    let senderName: String
    let senderImageName: String
    let text: String?
    let newsImageName: String?
    let type: NewsType
}
