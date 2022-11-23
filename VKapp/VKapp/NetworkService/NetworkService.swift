// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Network requests
final class NetworkService {
    // MARK: - Public Methods

    func fetchData(urlString: String) {
        AF
            .request(urlString).responseJSON { response in
                guard let value = response.value else { return }
                print(value)
            }
    }
}
