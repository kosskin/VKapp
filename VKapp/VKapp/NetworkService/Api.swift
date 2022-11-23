// Api.swift
// Copyright © RoadMap. All rights reserved.

/// API
enum Api {
    static let baseURL = "https://api.vk.com/method/"
    static let accessToken = "&access_token=\(Session.shared.token)"
    static let version = "&v=5.131"
    static let frinedFields = "&fields=nickname"
    static let friendsGet = "friends.get?"
    static let photosGet = "photos.getAll?"
    static let ownerId = "&owner_id="
    static let exampleId = 307_626_578
    static let groupsGet = "groups.get?"
    static let userId = "userId=\(Session.shared.userId)"
    static let extended = "&extended=1"
    static let groupsSearch = "groups.search?"
    static let qSearch = "&q="
    static let exampleQ = "sport"
}
