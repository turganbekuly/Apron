//
//  SearchInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Storages

protocol SearchBusinessLogic {
    func addSearchQueryToHistory(_ query: String)
    func searchQueries() -> [SearchHistoryItem]
    func removeSearchQuery(id: Int)
    func removeAllSearchQueries()
}

final class SearchInteractor: SearchBusinessLogic {
    
    // MARK: - Properties
    private let presenter: SearchPresentationLogic
    private let provider: SearchProviderProtocol
    
    // MARK: - Initialization
    init(presenter: SearchPresentationLogic,
         provider: SearchProviderProtocol = SearchProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - SearchBusinessLogic


    func addSearchQueryToHistory(_ query: String) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let queries = searchQueries()
        if let lastQuery = queries.first?.text, query == lastQuery {
            return
        }
        let key = String(describing: self)
        SearchHistoryManager(key: "\(key)").addQuery(query)
    }
    func searchQueries() -> [SearchHistoryItem] {
        let key = String(describing: self)
        return SearchHistoryManager(key: "\(key)").queries().reversed()
    }
    func removeSearchQuery(id: Int) {
        let key = String(describing: self)
        SearchHistoryManager(key: "\(key)").removeQuery(id: id)
    }
    func removeAllSearchQueries() {
        let key = String(describing: self)
        SearchHistoryManager(key: "\(key)").removeAllQueries()
    }
}
