//
//  NewsTextCell.swift
//  VKapp
//
//  Created by Валентин Коскин on 05.12.2022.
//

import UIKit

/// describe 1 post with text only
class NewsTextCell: UITableViewCell, NewsConfigurable {
    
    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    // MARK: - Public Methods

    func setCell(news: News) {
        senderImageView.image = UIImage(named: news.senderImageName)
        senderNameLabel.text = news.senderImageName
        guard let postText = news.text else { return }
        postTextLabel.text = postText
    }
}
