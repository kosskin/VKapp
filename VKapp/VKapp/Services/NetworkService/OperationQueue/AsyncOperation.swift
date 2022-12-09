//
//  AsyncOperation.swift
//  VKapp
//
//  Created by Валентин Коскин on 08.12.2022.
//

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
            return Constants.isText + rawValue.capitalized
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
        return true
    }
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    override var isExecuting: Bool {
        return state == .executing
    }
    override var isFinished: Bool {
        return state == .finished
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
