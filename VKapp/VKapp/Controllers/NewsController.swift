// NewsController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// News screen
final class NewsController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let xibCellName = "NewsCell"
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
        static let xibTextCellName = "NewsTextCell"
    }

    // MARK: - IBOutlets

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties
    
    private let networkService = NetworkService()
    private var news: [NewsFeed] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        fetchNews()
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
            UINib(nibName: Constants.xibTextCellName, bundle: nil),
            forCellReuseIdentifier: Constants.xibTextCellName
        )
        newsTableView.register(
            UINib(nibName: Constants.xibCellName, bundle: nil),
            forCellReuseIdentifier: Constants.xibCellName
        )
    }
    
    private func fetchNews() {
        networkService.fetchNews(urlString: RequestType.news.urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(post):
                self.fetchPost(response: post)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchPost(response: NewsFeedResponse) {
        response.news.forEach { item in
            if item.sourceID < 0 {
                guard let group = response.groups.filter({ group in
                    group.id == item.sourceID * -1
                }).first else { return }
                item.authorName = group.nameGroup
                item.avaratPath = group.photo
            } else {
                guard let user = response.friends.filter({ friend in
                    friend.id == item.sourceID
                }).first else { return }
                item.authorName = "\(user.firstName) \(user.lastName)"
                item.avaratPath = user.imageName
            }
        }
        DispatchQueue.main.async {
            self.news = response.news
            self.newsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension NewsController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNews = news[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.xibCellName,
                                                       for: indexPath) as? NewsCell else {
                                                        return UITableViewCell() }
        cell.configure(news: currentNews, service: networkService)
        return cell as? UITableViewCell ?? UITableViewCell()
    }
}
