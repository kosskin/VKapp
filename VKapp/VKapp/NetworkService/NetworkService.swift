// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Network requests
final class NetworkService {
    // MARK: - Constants

    private enum Constants {
        static let scheme = "https"
        static let host = "oauth.vk.com"
        static let path = "/authorize"
        static let urlQueryItemClientName = "client_id"
        static let urlQueryItemClientValue = "51484462"
        static let urlQueryItemDisplayName = "display"
        static let urlQueryItemDisplayValue = "mobile"
        static let urlQueryItemRedirectUriName = "redirect_uri"
        static let urlQueryItemRedirectUriValue = "https://oauth.vk.com/blank.html"
        static let urlQueryItemScopeName = "scope"
        static let urlQueryItemScopeValue = "262150"
        static let urlQueryItemResponseTypeName = "response_type"
        static let urlQueryItemResponseTypeValue = "token"
        static let urlQueryItemVName = "v"
        static let urlQueryItemVValue = "5.131"
    }

    // MARK: - Public Methods

    func fetchFriend(urlString: String, completion: @escaping (Result<[Friend], Error>) -> Void) {
        AF
            .request(urlString).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let object = try JSONDecoder().decode(FriendResult.self, from: data)
                    completion(.success(object.response.friends))
                } catch {
                    completion(.failure(error))
                }
            }
    }

    func fetchGroup(urlString: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        AF
            .request(urlString).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let object = try JSONDecoder().decode(GroupResult.self, from: data)
                    completion(.success(object.response.groups))
                } catch {
                    completion(.failure(error))
                }
            }
    }

    func fetchPhoto(urlString: String, completion: @escaping (Result<PhotoResult, Error>) -> Void) {
        AF
            .request(urlString).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let object = try JSONDecoder().decode(PhotoResult.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
    }

    func loadImageData(imageURL: String) -> Data {
        var dataImage = Data()
        guard let url = URL(string: imageURL),
              let data = try? Data(contentsOf: url)
        else { return dataImage }
        dataImage = data
        return dataImage
    }

    func createURLToLoadWebView() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        urlComponents.queryItems = [
            URLQueryItem(name: Constants.urlQueryItemClientName, value: Constants.urlQueryItemClientValue),
            URLQueryItem(name: Constants.urlQueryItemDisplayName, value: Constants.urlQueryItemDisplayValue),
            URLQueryItem(name: Constants.urlQueryItemRedirectUriName, value: Constants.urlQueryItemRedirectUriValue),
            URLQueryItem(name: Constants.urlQueryItemScopeName, value: Constants.urlQueryItemScopeValue),
            URLQueryItem(name: Constants.urlQueryItemResponseTypeName, value: Constants.urlQueryItemResponseTypeValue),
            URLQueryItem(name: Constants.urlQueryItemVName, value: Constants.urlQueryItemVValue)
        ]
        return urlComponents.url
    }
}
