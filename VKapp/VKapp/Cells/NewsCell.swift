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

    func configure(news: NewsFeed, service: NetworkService) {
        guard let photoUrl = news.avaratPath else { return }
        guard let photoNewsUrl = news.attachments?.first?.photo?.photos.last?.url else { return }
        senderImageView.loadImage(imageURL: photoUrl, service: service)
        postImageView.loadImage(imageURL: photoNewsUrl, service: service)
        senderNameLabel.text = news.authorName
        postTextLabel.text = news.text
        postDateLabel.text = DateFormatter.convert(timestamp: news.date)
    }
}
