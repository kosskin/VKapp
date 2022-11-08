// LoaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class LoaderView: UIView {
    // MARK: Private Properties

    private var loaderStackView: UIStackView?
    private lazy var pointViews: [UIView] = []

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    // MARK: - Public Methods

    override func layoutSubviews() {
        loaderStackView?.frame = bounds
    }

    // MARK: Private Methods

    private func setUpView() {
        for _ in 0 ..< 3 {
            let view = UIView()
            view.backgroundColor = .systemBlue
            view.tintColor = .red
            view.heightAnchor.constraint(equalToConstant: bounds.height - 5).isActive = true
            view.layer.cornerRadius = (bounds.height - 5) / 2
            view.alpha = 0.5
            view.layer.masksToBounds = true
            pointViews.append(view)
        }
        loaderStackView = UIStackView(arrangedSubviews: pointViews)

        guard let loaderStackView = loaderStackView else { return }
        loaderStackView.spacing = 8
        loaderStackView.axis = .horizontal
        loaderStackView.alignment = .center
        loaderStackView.distribution = .fillEqually
        addSubview(loaderStackView)
        animatePoints()
    }

    private func animatePoints() {
        var delay = 0.0
        pointViews.forEach { point in
            delay += 0.3
            makeOpacity(for: point, delay: delay)
        }
    }

    private func makeOpacity(for view: UIView, delay: Double) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.duration = 0.7
        animation.beginTime = CACurrentMediaTime() + delay
        animation.repeatCount = .infinity
        animation.fillMode = .backwards
        animation.autoreverses = true
        view.layer.add(animation, forKey: nil)
    }
}
