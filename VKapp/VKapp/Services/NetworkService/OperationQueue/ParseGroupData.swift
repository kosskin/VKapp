//
//  ParseGroupData.swift
//  VKapp
//
//  Created by Валентин Коскин on 08.12.2022.
//

import Foundation

/// Parse data of groups
final class ParseGroupData: Operation {
    
    // MARK: Public Properties
    
    var outputData: [Group] = []
    
    // MARK: Public Methods
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
                let data = getDataOperation.data else { return }
        do {
            let response = try JSONDecoder().decode(GroupResult.self, from: data)
            outputData = response.response.groups
        } catch {
            print(error.localizedDescription)
        }
    }
}
