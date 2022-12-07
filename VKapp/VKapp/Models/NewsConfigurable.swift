//
//  NewsConfigurable.swift
//  VKapp
//
//  Created by Валентин Коскин on 06.12.2022.
//

import UIKit

/// Protocolt guarantee that news is configurable
protocol NewsConfigurable {
    func setCell(news: News)
}
