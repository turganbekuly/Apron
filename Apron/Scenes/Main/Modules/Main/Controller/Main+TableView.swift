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
        case .myCommunities:
            let cell: MyCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .communities:
            let cell: DynamicCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .myCommunities:
            return 3
        case .communities:
            return 320
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .myCommunities:
            guard let cell = cell as? MyCommunityCell else { return }
            cell.delegate = self
            cell.configure(with: CollectionDelegateCellViewModel(
                sectionHeaderTitle: "Мое сообщество",
                collectionDelegate: self
            ))
        case let .communities(sectionTitle):
            guard let cell = cell as? DynamicCommunityCell else { return }
            cell.delegate = self
            myRecipes.compactMap {
                if $0.sectionTitle == sectionTitle {
                    communitiesSection = [.init(section: .communities, rows: $0.communities.compactMap { .community($0) })]
                }
            }
            cell.configure(with: CollectionDelegateCellViewModel(
                sectionHeaderTitle: sectionTitle,
                collectionDelegate: self
            ))
        }
    }
}
