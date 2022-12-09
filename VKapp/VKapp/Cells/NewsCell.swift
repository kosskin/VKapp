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

    func configure(news: NewsFeed, service: NetworkService) {
        guard let photoUrl = news.avaratPath else { return }
        senderImageView.loadImage(imageURL: photoUrl, service: service)
        senderNameLabel.text = news.authorName
        postTextLabel.text = news.text
        postImageView.image = UIImage(named: news.postImage ?? "")
        postDateLabel.text = formatData(timestamp: news.date)
    }

    // MARK: - Private Methods

    private func formatData(timestamp: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date as Date)
        return String(localDate)
    }
}
