// NewsController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// News screen
final class NewsController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let xibCellName = "NewsCell"
        static let xibCellId = "newsCell"
        static let senderNameOne = "Natasha"
        static let senderNameTwo = "Anna"
        static let senderNameThree = "Alena"
        static let senderNameFour = "Angelina"
        static let senderImageNameOne = "putin"
        static let senderImageNameTwo = "peskov"
        static let senderImageNameThree = "bolt"
        static let senderImageNameFour = "mbape"
        static let textForAllPosts = """
        TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT TEXT
        TEXT TEXTTEXTTEXT TEXT TEXT TEXT TEXT
        TEEEEXT TEXT TEXT
        T
        E
        X
        T
        !!!
        AAAA
        АА
        А
        А
        А
        А
        А
        Я схожу с ума!
        """
        static let newImageNameOne = "neymar"
        static let newImageNameTwo = "sharapova"
        static let newImageNameThree = "kim"
        static let newImageNameFour = "mask"
        static let forTransitionId = "ForTransitionController"
    }

    // MARK: - IBOutlets

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private var news = [
        News(
            senderName: Constants.senderNameOne,
            senderImageName: Constants.senderImageNameOne,
            text: Constants.textForAllPosts,
            newsImageName: Constants.newImageNameOne
        ),
        News(
            senderName: Constants.senderNameTwo,
            senderImageName: Constants.senderImageNameTwo,
            text: Constants.textForAllPosts,
            newsImageName: Constants.newImageNameTwo
        ),
        News(
            senderName: Constants.senderNameThree,
            senderImageName: Constants.senderImageNameThree,
            text: Constants.textForAllPosts,
            newsImageName: Constants.newImageNameThree
        ),
        News(
            senderName: Constants.senderNameFour,
            senderImageName: Constants.senderImageNameFour,
            text: Constants.textForAllPosts,
            newsImageName: Constants.newImageNameFour
        )
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }

    // MARK: IBActions

    @IBAction private func goToVCAction(_ sender: Any) {
        guard let nextVC = storyboard?
            .instantiateViewController(identifier: Constants.forTransitionId) as? ForTransitionController
        else { return }
        navigationController?.pushViewController(nextVC, animated: true)
    }

    // MARK: - Private Methods

    private func registerCell() {
        newsTableView.register(
            UINib(nibName: Constants.xibCellName, bundle: nil),
            forCellReuseIdentifier: Constants.xibCellId
        )
    }
}

// MARK: - UITableViewDataSource

extension NewsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.xibCellId, for: indexPath) as? NewsCell
        else { return UITableViewCell() }
        cell.setCell(news: news[indexPath.row])
        return cell
    }
}
