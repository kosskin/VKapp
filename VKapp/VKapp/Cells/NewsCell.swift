// NewsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// describe one cell in News Table View
final class NewsCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet private var senderImageView: UIImageView!
    @IBOutlet private var senderNameLabel: UILabel!
    @IBOutlet private var postTextView: UITextView!
    @IBOutlet private var postImageView: UIImageView!

    // MARK: - Public Methods

    func setCell(news: News) {
        senderImageView.image = UIImage(named: news.senderImageName)
        senderNameLabel.text = news.senderImageName
        guard let postText = news.text,
              let postImage = news.newsImageName else { return }
        postTextView.text = postText
        postImageView.image = UIImage(named: postImage)
    }
}
