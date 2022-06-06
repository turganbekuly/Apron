//
//  CommunityPage+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
import DesignSystem

extension CommunityPageViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipiesView:
            let cell: CommunityRecipeCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .emptyView:
            let cell: EmptyCartCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension CommunityPageViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleScrollForImage(contentOffset: scrollView.contentOffset.y)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipiesView(recipe):
            let vc = RecipePageBuilder(state: .initial(id: recipe.id)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: false)
            }
        default:
            break
        }
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipiesView:
            let height = (Int(tableView.bounds.width) / 2) + 60
            return CGFloat(height > 0 ? height : 0)
        case .emptyView:
            return 230
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .recipiesView:
            let height = (Int(tableView.bounds.width) / 2) + 60
            return CGFloat(height > 0 ? height : 0)
        case .emptyView:
            return 230
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .recipiesView(recipe):
            guard let cell = cell as? CommunityRecipeCell else { return }
            cell.delegate = self
            cell.configure(with: CommunityRecipesCellViewModel(recipe: recipe))
        case .emptyView:
            guard let cell = cell as? EmptyCartCell else { return }
            cell.configure(
                with: "Добавьте рецепты в сообщество",
                image: ApronAssets.emptyRecipesIcon.image
            )
        }
    }


    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .topView:
            let view: CommunityInfoHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .topView:
            return 248
        }
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .topView:
            return 248
        }
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .topView:
            guard let view = view as? CommunityInfoHeaderView else { return }
            view.filterViewDelegate = self
            view.segmentDelegate = self
            view.configure(with: CommunityInfoCellViewModel(
                community: community,
                searchbarPlaceholder: community?.name ?? ""
            ))
        }
    }
}
