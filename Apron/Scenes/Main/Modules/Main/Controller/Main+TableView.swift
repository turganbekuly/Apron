//
//  Main+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .communities:
            let cell: CommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .whatToCook:
            let cell: WhatToCookCell = tableView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        case .cookNow, .eventRecipes:
            let cell: CookNowCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .adBanner:
            let cell: AdBannerCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .searchByIngredients:
            let cell: SBIMainTableCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .communities:
            return communities.isEmpty ? 0 : ((UIScreen.main.bounds.width / 2) + 66) * 1.2
        case .whatToCook:
            let rawCount = CGFloat(WhatToCookCategoryTypes.allCases.count / 3)
            let categoryCellHeight: CGFloat = ((UIScreen.main.bounds.width + 60) * 168.0) / 375.0
            return rawCount * categoryCellHeight
        case .cookNow, .eventRecipes:
            return 185
        case .adBanner:
            return adBanners.count == 0 ? 0 : ((UIScreen.main.bounds.width / 375) * 134) + 60
        case .searchByIngredients:
            return 150
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .communities:
            return communities.isEmpty ? 0 : ((UIScreen.main.bounds.width / 2) + 66) * 1.2
        case .whatToCook:
            let rawCount = CGFloat(WhatToCookCategoryTypes.allCases.count / 3)
            let categoryCellHeight: CGFloat = ((UIScreen.main.bounds.width + 60) * 168.0) / 375.0
            return rawCount * categoryCellHeight
        case .cookNow, .eventRecipes:
            return 185
        case .adBanner:
            return adBanners.count == 0 ? 0 : ((UIScreen.main.bounds.width / 375) * 134) + 60
        case .searchByIngredients:
            return 150
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .communities(title, communities):
            guard let cell = cell as? CommunityCell else { return }
            cell.delegate = self
            cell.configure(
                with: CommunityCellViewModel(
                    sectionHeaderTitle: title,
                    communities: communities
                )
            )
        case let .whatToCook(sectionTitle):
            guard let cell = cell as? WhatToCookCell else { return }
            cell.configure(
                with: WhatToCookCellViewModel(
                    sectionHeaderTitle: sectionTitle,
                    categories: WhatToCookCategoryTypes.allCases
                )
            )
        case let .cookNow(sectionTitle, _):
            guard let cell = cell as? CookNowCell else { return }
            cell.delegate = self
            cell.configure(
                with: CookNowCellViewModel(
                    sectionTitle: sectionTitle,
                    type: .cookNow,
                    state: cookNowRecipesState
                )
            )
        case let .eventRecipes(sectionTitle, _):
            guard let cell = cell as? CookNowCell else { return }
            cell.delegate = self
            cell.configure(
                with: CookNowCellViewModel(
                    sectionTitle: sectionTitle,
                    type: .eventRecipe,
                    state: eventRecipesState
                )
            )
        case let .adBanner(banners):
            guard let cell = cell as? AdBannerCell else { return }
            cell.delegate = self
            cell.configure(viewModel: banners)
            
        case let .searchByIngredients(sectionTitle, sectionDescr, products):
            guard let cell = cell as? SBIMainTableCell else { return }
            cell.delegate = self
            cell.configure(with: SBIMainViewModel(sectionTitle: sectionTitle, sectionDescription: sectionDescr, products: products))
        }
    }
}
