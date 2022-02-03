//
//  CommunityPage+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

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
        case .topView:
            let cell: CommunityInfoCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .filterView:
            let cell: CommunityFilterCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .segment:
            let cell: CommunitySegmentCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .recipiesView:
            let cell: CommunityRecipeCell = tableView.dequeueReusableCell(for: indexPath)
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
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return 144
        case .filterView:
            return 70
        case .segment:
            return 34
        case .recipiesView:
            let count = recipies.count
            let height = count * 270 - 9
            return CGFloat(height > 0 ? height : 0)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return 144
        case .filterView:
            return 70
        case .segment:
            return 34
        case .recipiesView:
            let count = recipies.count
            let height = count * 270 - 9
            return CGFloat(height > 0 ? height : 0)
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .topView(infoCell):
            guard let cell = cell as? CommunityInfoCell else { return }
            cell.configure(with: infoCell)
        case let .filterView(filter):
            guard let cell = cell as? CommunityFilterCell else { return }
            cell.configure(with: filter)
        case .segment:
            guard let cell = cell as? CommunitySegmentCell else { return }
            cell.delegate = self
            cell.configure(with: CommunitySegmentedCellViewModel(filter: .recipes))
        case .recipiesView:
            guard let cell = cell as? CommunityRecipeCell else { return }
            cell.configure(with: CommunityCollectionViewModel(recipesDelegate: self))
        }
    }
}
