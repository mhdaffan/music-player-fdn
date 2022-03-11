//
//  RealmRepository.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 11/03/22.
//

import Foundation
import RealmSwift

internal final class RealmRepository<T: RealmSwift.Object> {

    private let config: Realm.Configuration
    private var results: RealmSwift.Results<T>?
    private var notificationToken: NotificationToken?

    private var realm: Realm? {
        return try? Realm(configuration: config)
    }

    var dataDidChanged: (() -> Void)?

    init(_ configuration: RealmConfiguration) {

        config = configuration.value

        fetch()
    }

    // MARK: - Count

    /// Total number of items in realm
    ///
    /// - Returns: total number items in `Int`
    func numberOfItems() -> Int {

        guard let results = results else {
            return 0
        }

        return results.count
    }

    /// Total number of items in realm based of it's query
    ///
    /// - Parameter predicate: filter query
    /// - Returns: total number items in `Int`
    func numberOfItems(_ predicate: String) -> Int {

        guard let results = results,
            results.count != 0 else {

                return 0
        }

        return results.filter(predicate).count
    }

    // MARK: - Items

    /// Get `RealmSwift.Object` at specific index
    ///
    /// - Parameter index: index of object in Realm
    /// - Returns: `RealmSwift.Object`
    func item(atIndex index: Int) -> T? {

        guard let results = results,
            results.count != 0 else {

                return nil
        }

        return results[index]
    }

    /// Get `RealmSwift.Object` at specific index based on it's query
    ///
    /// - Parameters:
    ///   - index: index of `RealmSwift.Object` in `Int`
    ///   - predicate: filter query
    /// - Returns: `RealmSwift.Object`
    func item(atIndex index: Int, predicate: String) -> T? {

        guard let results = results,
            results.count != 0 else {

                return nil
        }

        return results.filter(predicate)[index]
    }

    func allItem() -> [T]? {

        var array: [T] = []
        guard let results = results,
            results.count != 0 else {
                return nil
        }
        results.forEach {(value) in
            array.append(value)
        }
        return array
    }

    /// Get value of `RealmSwift.Object`'s properties
    ///
    /// - Parameter keyPath: property name in `String`
    /// - Returns: Array of `RealmSwift.Object`
    func itemsAtValue<U>(forKeyPath keyPath: String) -> [U] {

        guard let results = results,
            results.count != 0,
            let items = results.value(forKeyPath: keyPath) as? [U] else {

                return []
        }

        return items
    }

    // MARK: - Fetch

    /// Get all object in realm
    func fetch() {
        results = realm?.objects(T.self)

        configureNotification()
    }

    /// Sort `RealmSwift.Object` based on it's property
    ///
    /// - Parameters:
    ///   - keyPath: Property of `RealmSwift.Object`
    ///   - ascending: Set true for ascending, false for desending, default true
    func sorted(byKeyPath keyPath: String, ascending: Bool = true) {
        results = results?.sorted(byKeyPath: keyPath, ascending: ascending)

        configureNotification()
    }

    /// Sort multiple property of `RealmSwift.Object`
    ///
    /// - Parameters:
    ///   - by: Array of property in `RealmSwift.Object`
    func sorted(bys: [RealmSwift.SortDescriptor]) {
        results = results?.sorted(by: bys)

        configureNotification()
    }

    /// Filter objects in Realm based on it's predicate
    ///
    /// - Parameter predicate: NSPredicate's string
    func filter(_ predicate: String) {
        results = results?.filter(predicate)

        configureNotification()
    }
    
    /// Safely filter objects in Realm based on it's predicate
    ///
    /// - Parameters:
    ///   - filter: filter type e.g. `field == %@`, `field CONTAINS %@`, `etc`
    ///   - predicate: NSPredicate's string
    func filter(filter: String, _ predicate: String) {
        results = results?.filter(filter, predicate)
        configureNotification()
    }

    // MARK: - Operation

    /// Insert new `RealmSwift.Object` to Realm
    ///
    /// - Parameter item: `RealmSwift.Object`
    func insert(_ item: T) {

        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.add(item)
        }
    }

    /// Insert array of `RealmSwift.Object` to Realm
    ///
    /// - Parameter items: `RealmSwift.Object`
    func insert(_ items: [T]) {

        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.add(items)
        }
    }

    /// Update current `RealmSwift.Object` in Realm
    ///
    /// - Parameter object: `RealmSwift.Object`
    func update(_ item: T) {

        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.add(item, update: .all)
        }
    }

    /// Delete current `RealmSwift.Object` from Realm
    ///
    /// - Parameter object: `RealmSwift.Object`
    func delete(_ item: T) {

        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.delete(item)
        }
    }
    
    /// Delete array of `RealmSwift.Object` from Realm
    ///
    /// - Parameter items: `RealmSwift.Object`
    func delete(_ items: [T]) {
        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.delete(items)
        }
    }

    func deleteAllItem() {
        guard let realm = realm else {
            return
        }

        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func isEmpty() -> Bool {
        return realm?.isEmpty ?? true
    }

    // MARK: - Notification

    /// Stop listen to updated result
    func stopNotification() {
        notificationToken?.invalidate()
    }

    private func configureNotification() {

        stopNotification()

        notificationToken = results?.observe({ [weak self] _ in
            self?.dataDidChanged?()
        })
    }

    // MARK: - Deinit

    deinit {
        stopNotification()
    }

}

