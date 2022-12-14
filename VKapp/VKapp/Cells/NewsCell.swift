// NewsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// describe one cell in News Table View
final class NewsCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var senderImageView: UIImageView!
    @IBOutlet private var senderNameLabel: UILabel!
    @IBOutlet private var postTextLabel: UILabel!
    @IBOutlet private var postImageView: UIImageView!
    @IBOutlet private var postDateLabel: UILabel!

    // MARK: - Public Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }

    func configure(news: NewsFeed, service: PhotoCacheService) {
        guard let photoUrl = news.avaratPath,
              let photoNewsUrl = news.attachments?.first?.photo?.photos.last?.url else { return }
        senderImageView.image = service.photo(byUrl: photoUrl)
        postImageView.image = service.photo(byUrl: photoNewsUrl)
        senderNameLabel.text = news.authorName
        postTextLabel.text = news.text
        postDateLabel.text = DateFormatter.convert(timestamp: news.date)
    }
}
