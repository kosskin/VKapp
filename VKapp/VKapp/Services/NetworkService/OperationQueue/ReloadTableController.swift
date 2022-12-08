//
//  ReloadTableController.swift
//  VKapp
//
//  Created by Валентин Коскин on 08.12.2022.
//

import RealmSwift

final class ReloadTableController: Operation {
    
    // MARK: - Public Methods
    
    override func main() {
        guard let getParseData = dependencies.first as? ParseGroupData else { return }
        let parseData = getParseData.outputData
        do {
            let realm = try Realm()
            guard let oldData = RealmService.get(Group.self) else { return }
            try realm.write {
                realm.delete(oldData)
                realm.add(parseData)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
