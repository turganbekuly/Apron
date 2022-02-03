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
        case .featuredCommunities:
            let cell: FeaturedCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .quickSimpleCommunities:
            let cell: QuickCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .healthyCommunities:
            let cell: HealthyCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .homemadeCommunities:
            let cell: HomemadeCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        default:
            return 300
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row: MainViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .myCommunities:
            guard let cell = cell as? MyCommunityCell else { return }
            cell.delegate = self
            cell.configure(with: CollectionDelegateCellViewModel(collectionDelegate: self))
        case .featuredCommunities:
            guard let cell = cell as? FeaturedCommunityCell else { return }
            cell.delegate = self
            cell.configure(with: CollectionDelegateCellViewModel(collectionDelegate: self))
        case .quickSimpleCommunities:
            guard let cell = cell as? QuickCommunityCell else { return }
            cell.delegate = self
            cell.configure(with: CollectionDelegateCellViewModel(collectionDelegate: self))
        case .healthyCommunities:
            guard let cell = cell as? HealthyCommunityCell else { return }
            cell.delegate = self
            cell.configure(with: CollectionDelegateCellViewModel(collectionDelegate: self))
        case .homemadeCommunities:
            guard let cell = cell as? HomemadeCommunityCell else { return }
            cell.delegate = self
            cell.configure(with: CollectionDelegateCellViewModel(collectionDelegate: self))
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        default:
            let view: CommunityCellHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        default:
            return 16
        }
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        default:
            return 16
        }
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .my:
            guard let view = view as? CommunityCellHeaderView else { return }
            view.configure(with: "Мои Сообщества")
        case .featured:
            guard let view = view as? CommunityCellHeaderView else { return }
            view.configure(with: "Популярные Сообщества")
        case .quickSimple:
            guard let view = view as? CommunityCellHeaderView else { return }
            view.configure(with: "Быстро и просто")
        case .healthy:
            guard let view = view as? CommunityCellHeaderView else { return }
            view.configure(with: "Правильное питание")
        case .homemade:
            guard let view = view as? CommunityCellHeaderView else { return }
            view.configure(with: "Домашняя еда")
        }
    }
}
