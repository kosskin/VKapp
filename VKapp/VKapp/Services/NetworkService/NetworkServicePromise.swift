// NetworkServicePromise.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import PromiseKit

/// Network service with PromiseKit
final class NetworkServicePromise {
    // MARK: - Public Methods

    func fetchFriends(urlSting: String) -> Promise<[Friend]> {
        Promise<[Friend]> { resolver in
            DispatchQueue.main.async {
                AF.request(urlSting).responseData { response in
                    guard let data = response.data else { return }
                    do {
                        let responseJson = try JSONDecoder().decode(FriendResult.self, from: data)
                        resolver.fulfill(responseJson.response.friends)
                    } catch {
                        resolver.reject(error)
                    }
                }
            }
        }
    }
}
