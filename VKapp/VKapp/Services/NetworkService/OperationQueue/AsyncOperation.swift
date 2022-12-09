// AsyncOperation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// For asynchonic operation
class AsyncOperation: Operation {
    // MARK: - Constants

    private enum Constants {
        static let isText = "is"
    }

    /// state of current operation
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            Constants.isText + rawValue.capitalized
        }
    }

    // MARK: - Public Properties

    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }

    override var isAsynchronous: Bool {
        true
    }

    override var isReady: Bool {
        super.isReady && state == .ready
    }

    override var isExecuting: Bool {
        state == .executing
    }

    override var isFinished: Bool {
        state == .finished
    }

    // MARK: - Public Methods

    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }

    override func cancel() {
        super.cancel()
        state = .finished
    }
}
