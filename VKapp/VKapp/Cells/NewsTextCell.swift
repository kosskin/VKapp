//
//  NewsTextCell.swift
//  VKapp
//
//  Created by Валентин Коскин on 05.12.2022.
//

import UIKit

/// describe 1 post with text only
final class NewsTextCell: UITableViewCell {
    
    // MARK: - IBOUtlets
    
    @IBOutlet private var senderImageView: UIImageView!
    @IBOutlet private var senderNameLabel: UILabel!
    @IBOutlet private var postTextLabel: UILabel!
    
    // MARK: - Public Methods

    func configure(news: NewsFeed, service: NetworkService) {
        guard let photoUrl = news.avaratPath else { return }
        senderImageView.loadImage(imageURL: photoUrl, service: service)
        senderNameLabel.text = news.authorName
        postTextLabel.text = news.text
    }
}
