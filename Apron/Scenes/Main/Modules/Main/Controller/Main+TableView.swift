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
            let cell: DynamicCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .whatToCook:
            let cell: WhatToCookCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .communities:
            return dynamicCommunities.isEmpty ? 0 : 305
        case .whatToCook:
            let rawCount = WhatToCookCategoryTypes.allCases.count / 2
            return CGFloat(rawCount * 170)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .communities:
            return dynamicCommunities.isEmpty ? 0 : 305
        case .whatToCook:
            let rawCount = WhatToCookCategoryTypes.allCases.count / 2
            return CGFloat(rawCount * 170)
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .communities(title, communities, categoryID):
            guard let cell = cell as? DynamicCommunityCell else { return }
            cell.delegate = self
            cell.configure(with: DynamicCollectionDelegateCellViewModel(
                sectionHeaderTitle: title,
                categoryID: categoryID,
                dynamicCommunities: communities
            ))
        case let .whatToCook(sectionTitle):
            guard let cell = cell as? WhatToCookCell else { return }
            cell.configure(with: WhatToCookCellViewModel(
                sectionHeaderTitle: sectionTitle,
                categories: WhatToCookCategoryTypes.allCases
            ))
        }
    }
}
