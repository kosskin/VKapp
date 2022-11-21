// ForTransitionController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// for demonstration animate transition
final class ForTransitionController: UIViewController {
    // MARK: - Private Properties

    private var interactiveTransition = CustomInteractiveTransition()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
