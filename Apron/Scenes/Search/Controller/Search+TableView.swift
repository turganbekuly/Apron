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
        case .category:
            let cell: SearchSuggestionCategoriesCell = tableView.dequeueReusableCell(for: indexPath)
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
        case .category:
            let rowCount = (SearchSuggestionCategoriesTypes.allCases.count / 2) + 1
            return CGFloat(rowCount * 176)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .category:
            let rowCount = (SearchSuggestionCategoriesTypes.allCases.count / 2) + 1
            return CGFloat(rowCount * 176)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .category:
            guard let cell = cell as? SearchSuggestionCategoriesCell else { return }
            cell.suggestionCategoriesView.delegate = self
            cell.suggestionCategoriesView.dataSource = self
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .categories:
            let view: SearchHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .categories:
            return 45
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .categories:
            return 45
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .categories:
            guard let view = view as? SearchHeaderView else { return }
            view.delegate = self
            view.configure()
        }
    }
}
