// RequestType.swift
// Copyright © RoadMap. All rights reserved.

/// type of request
enum RequestType {
    case friends
    case groups
    case photos(id: Int)
    case searchGroups(searchQuery: String)

    // MARK: - Public Properties

    var urlString: String {
        switch self {
        case .friends:
            return "\(Api.baseURL)\(Api.friendsGet)\(Api.accessToken)\(Api.frinedFields)\(Api.version)"
        case let .photos(id):
            return "\(Api.baseURL)\(Api.photosGet)\(Api.accessToken)\(Api.extended)\(Api.version)\(Api.ownerId)\(id)"
        case .groups:
            return "\(Api.baseURL)\(Api.groupsGet)\(Api.userId)\(Api.extended)\(Api.accessToken)\(Api.version)"
        case let .searchGroups(searchQuery):
            return "\(Api.baseURL)\(Api.groupsSearch)\(Api.accessToken)\(Api.qSearch)\(searchQuery)\(Api.version)"
        }
    }
}
