// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Extension for adding image from Internet
extension UIImageView {
    func loadImage(imageURL: String, service: NetworkService) {
        DispatchQueue.main.async {
            guard let data = service.loadImageData(imageURL: imageURL),
                  let image = UIImage(data: data) else { return }
            self.image = image
        }
    }
}
