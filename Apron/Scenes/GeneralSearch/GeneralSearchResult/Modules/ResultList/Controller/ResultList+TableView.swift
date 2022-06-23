//
//  ResultList+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension ResultListViewController: UITableViewDataSource {
    
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
        case .community:
            let cell: GeneralSearchCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .recipe:
            let cell: GeneralSearchRecipeCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .loading:
            let cell: GeneralSearchShimmerView = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension ResultListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .community(community):
            ApronAnalytics.shared.sendAmplitudeEvent(
                .searchMade(
                    SearchMadeModel(
                    searchTerm: query ?? "",
                    sourceType: sourceType,
                    selectedItemTab: "\(initialState ?? .everything)",
                    selectedItemName: community.name ?? ""
                    )
                )
            )
        case let .recipe(recipe):
            ApronAnalytics.shared.sendAmplitudeEvent(
                .searchMade(
                    SearchMadeModel(
                    searchTerm: query ?? "",
                    sourceType: sourceType,
                    selectedItemTab: "\(initialState ?? .everything)",
                    selectedItemName: recipe.recipeName ?? ""
                    )
                )
            )
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .community:
            return 72
        case .recipe:
            return 72
        case .loading:
            return 72
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .community:
            return 72
        case .recipe:
            return 72
        case .loading:
            return 72
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipe(recipe):
            guard let cell = cell as? GeneralSearchRecipeCell else { return }
            cell.configure(with: GeneralSearchRecipeViewModel(recipe: recipe))
        case let .community(community):
            guard let cell = cell as? GeneralSearchCommunityCell else { return }
            cell.configure(with: GeneralSearchCommunityViewModel(community: community))
        default:
            break
        }
    }
}
