//
//  Search+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension SearchViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .searchHistory:
            let cell: SearchHistoryCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .searchHistory:
            let searchItemsCount = ceil(CGFloat(searchHistoryItems.count / 2))
            return searchItemsCount <= 1 ? 120 : searchItemsCount * 120
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .searchHistory:
            let searchItemsCount = ceil(CGFloat(searchHistoryItems.count / 2))
            return searchItemsCount <= 1 ? 120 : searchItemsCount * 120
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .searchHistory:
            guard let cell = cell as? SearchHistoryCell else { return }
            cell.historyCollectionView.delegate = self
            cell.historyCollectionView.dataSource = self
            cell.configure(with: "История поиска")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .search:
            let view: SearchHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .search:
            return 45
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .search:
            return 45
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .search:
            guard let view = view as? SearchHeaderView else { return }
            view.delegate = self
            view.configure()
        }
    }
    
}
