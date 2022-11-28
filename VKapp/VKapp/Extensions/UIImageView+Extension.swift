// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Extension for adding image from Internet
extension UIImageView {
    func loadImage(imageURL: String) {
        let networkService = NetworkService()
        DispatchQueue.main.async {
            guard let image = UIImage(data: networkService.loadImageData(imageURL: imageURL)) else { return }
            self.image = image
        }
    }
}
