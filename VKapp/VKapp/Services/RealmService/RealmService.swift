// RealmService.swift
// Copyright © RoadMap. All rights reserved.

import RealmSwift

/// Database Realm
final class RealmService {
    // MARK: - Public Methods

    func saveFriendToRealm(_ friends: [Friend]) {
        do {
            let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: configuration)
            try realm.write {
                realm.add(friends, update: .modified)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveGroupToRealm(_ groups: [Group]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(groups, update: .modified)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func savePhotosToRealm(_ photos: [Photos]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(photos, update: .modified)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
