//
//  SearchHistoryManager.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 18.07.2022.
//

import Foundation

public struct SearchHistoryItem: Codable {
    public let id: Int
    public let text: String
}

public final class SearchHistoryManager {
    // MARK: - Private properties

    private let key: String
    private let userDefaults = UserDefaults.standard

    // MARK: - Init

    public init(key: String) {
        self.key = key
    }

    // MARK: - Public methods

    public func addQuery(_ query: String) {
        var allQueries = queries()

        let id = generateNewIdentifierForItem()
        allQueries.append(.init(id: id, text: query))

        if let encoded = try? JSONEncoder().encode(allQueries) {
            userDefaults.setValue(encoded, forKey: key)
        }
    }

    public func removeQuery(id: Int) {
        var queries = fetchItemsFromStorage()
        queries.removeAll(where: { $0.id == id })

        if let encoded = try? JSONEncoder().encode(queries) {
            userDefaults.setValue(encoded, forKey: key)
        }
    }

    public func removeAllQueries() {
        userDefaults.removeObject(forKey: key)
    }

    public func queries() -> [SearchHistoryItem] {
        return fetchItemsFromStorage()
    }

    // MARK: - Private methods

    private func generateNewIdentifierForItem() -> Int {
        let items = fetchItemsFromStorage()

        if items.isEmpty {
            return 0
        } else {
            guard let lastId = items.last?.id else { return 0 }
            return lastId + 1
        }
    }

    private func fetchItemsFromStorage() -> [SearchHistoryItem] {
        guard let storageValue = userDefaults.value(forKey: key) as? Data else {
            return []
        }

        let decoder = JSONDecoder()
        guard let items = try? decoder.decode([SearchHistoryItem].self, from: storageValue) else {
            return []
        }

        return items
    }
}
