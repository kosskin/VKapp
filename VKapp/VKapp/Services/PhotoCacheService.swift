// PhotoCacheService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Service for caching photos
final class PhotoCacheService {
    // MARK: - Private Constants

    private enum Constants {
        static let defaultText = "default"
        static let imagesText = "FriendsImages"
        static let separatorText: Character = "/"
        static let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    }

    // MARK: - Private Properies

    private let container: DataReloadable

    private let cacheLifeTime: TimeInterval = Constants.cacheLifeTime

    private static let pathName: String = {
        let pathName = Constants.imagesText
        guard let cachesDirectory = FileManager.default.urls(
            for:
            .cachesDirectory,
            in: .userDomainMask
        ).first else { return pathName }

        let url = cachesDirectory.appendingPathComponent(
            pathName,
            isDirectory:
            true
        )
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        return pathName
    }()

    private var images = [String: UIImage]()

    // MARK: Init

    init(container: UITableView) {
        self.container = Table(table: container)
    }

    // MARK: - Public Methods

    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
        }
        return image
    }

    // MARK: - Private Methods

    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            self?.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(
            for:
            .cachesDirectory,
            in: .userDomainMask
        ).first else { return nil }
        guard let fileName = url.split(separator: Constants.separatorText).last else { return nil }
        return cachesDirectory.appendingPathComponent(
            "\(PhotoCacheService.pathName)\(Constants.separatorText)\(fileName)"
        ).path
    }

    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(
            atPath: fileName,
            contents: data,
            attributes: nil
        )
    }

    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(
                  atPath:
                  fileName
              ),
              let modificationDate = info[FileAttributeKey.modificationDate] as?
              Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
}
