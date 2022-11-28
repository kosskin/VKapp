// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Extension for adding image from Internet
extension UIImageView {
    func loadImage(imageURL: String) {
        DispatchQueue.main.async {
            guard let url = URL(string: imageURL),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            self.image = image
        }
    }
}
