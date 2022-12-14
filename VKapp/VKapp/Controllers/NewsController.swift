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
        static let refreshingText = "Refreshing..."
        static let emptyString = ""
    }

    // MARK: - IBOutlets

    @IBOutlet private var newsTableView: UITableView!

    // MARK: - Private Properties

    private let networkService = NetworkService()
    private var newsFeed: [NewsFeed] = []
    private var isLoading = false
    private var nextPage = ""
    private var currentDate = 0

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addPrefetchDataSource()
        registerCell()
        fetchNews()
        setupRefreshControl()
    }

    // MARK: IBActions

    @IBAction private func goToVCAction(_: Any) {
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
        newsTableView.refreshControl?.beginRefreshing()
        var mostFreshDate: TimeInterval?
        if let firstItem = newsFeed.first {
            mostFreshDate = firstItem.date + 1
        }
        networkService
            .fetchNews(urlString: RequestType.news.urlString, startTime: mostFreshDate) { [weak self] result in
                guard let self = self else { return }
                self.newsTableView.refreshControl?.endRefreshing()
                switch result {
                case let .success(data):
                    self.newsFeed = self.updateNews(response: data) + self.newsFeed
                    self.nextPage = data.nextPage ?? Constants.emptyString
                    self.newsTableView.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }

    private func updateNews(response: NewsFeedResponse) -> [NewsFeed] {
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
        return response.news
    }

    private func setupRefreshControl() {
        newsTableView.refreshControl = UIRefreshControl()
        newsTableView.refreshControl?.attributedTitle = NSAttributedString(string: Constants.refreshingText)
        newsTableView.refreshControl?.tintColor = .green
        newsTableView.refreshControl?.addTarget(self, action: #selector(refreshNewsAction), for: .valueChanged)
    }

    private func addPrefetchDataSource() {
        newsTableView.prefetchDataSource = self
    }

    @objc private func refreshNewsAction() {
        fetchNews()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension NewsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in _: UITableView) -> Int {
        newsFeed.count
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNews = newsFeed[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.xibCellName,
            for: indexPath
        ) as? NewsCell
        else {
            return UITableViewCell()
        }
        cell.configure(news: currentNews, service: networkService)
        return cell as UITableViewCell
    }

    /* СДЕЛАЛ МЕТОД ПО УКАЗАНИЮ ВЫСОТЫ ЯЧЕЙКИ, РАСЧИТЫВАЕМОЙ ЧЕРЕЗ СООТНОШЕНИЕ СТОРОН ФОТОГРАФИИ,
     НО У МЕНЯ В ПРОЕКТЕ НЕТ ОТДЕЛЬНО ХЕДЕРА/ФУТЕРА/ТЕКСТА/ФОТОГРАФИИ, А СДЕЛАНО ВСЁ ОДНОЙ ЯЧЕЙКОЙ,
     ПОЭТОМУ КОГДА ПРИМЕНЯЮ ЭТОТ МЕТОД СЪЕЗЖАЮТ ВСЕ НОВОСТИ(ВЫСОТА ВСЕЙ НОВОСТИ СТАНОВИТСЯ РАВНОЙ
     ПРЕДПОЛАГАЕМОЙ ВЫСОТЕ ФОТОГРАФИИ, ПОЭТОМУ ОСТАВИЛ ВСЁ ТАК. ну и ещё потому что рукожоп)
     */

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let currentNews = newsFeed[indexPath.section]
//        let tableWidth = newsTableView.bounds.width
//        let cellHeight = tableWidth * (currentNews.attachments?.first?.photo?.photos.first?.aspectRatio ?? 1)
//        return cellHeight
//    }
}

// MARK: - UITableViewDataSourcePrefetching

extension NewsController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map(\.section).max() else { return }
        if maxSection > newsFeed.count - 3, !isLoading {
            isLoading = true
            networkService.fetchNews(
                urlString: RequestType.news.urlString,
                nextPage: nextPage,
                startTime: Double(currentDate)
            ) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(data):
                    let indexSet = IndexSet(integersIn: self.newsFeed.count ..< self.newsFeed.count + data.news.count)
                    let updatingNews = self.updateNews(response: data)
                    self.newsFeed.append(contentsOf: updatingNews)
                    self.currentDate = Int(updatingNews.first?.date ?? 0)
                    self.newsTableView.insertSections(indexSet, with: .automatic)
                    self.isLoading = false
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
