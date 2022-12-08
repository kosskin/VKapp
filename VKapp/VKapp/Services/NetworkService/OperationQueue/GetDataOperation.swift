//
//  GetDataOperation.swift
//  VKapp
//
//  Created by Валентин Коскин on 08.12.2022.
//

import Alamofire

/// Operation of loading data from Internet
final class GetDataOperation: AsyncOperation {
    
    // MARK: - Public Properties
    
    var data: Data?
    
    // MARK: - Private Properties
    
    private var request: DataRequest
    
    // MARK: - Initialisers
    
    init(request: DataRequest) {
        self.request = request
    }
    
    // MARK: - Public Methods
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
}
