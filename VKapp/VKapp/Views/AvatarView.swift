// AvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Shadow view  for avatar
final class AvatarView: UIView {
    // MARK: - Private Properties

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0.8 {
        didSet {
            updateShadowOpacity()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowRadius: CGFloat = 10 {
        didSet {
            updateShadowRadius()
            setNeedsDisplay()
        }
    }

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // MARK: - Private Methods

    private func configure() {
        setupShadow()
        updateShadowColor()
        updateShadowOpacity()
        updateShadowRadius()
    }

    private func setupShadow() {
        layer.cornerRadius = bounds.width / 2
    }

    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }

    private func updateShadowOpacity() {
        layer.shadowOpacity = shadowOpacity
    }

    private func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }
}
