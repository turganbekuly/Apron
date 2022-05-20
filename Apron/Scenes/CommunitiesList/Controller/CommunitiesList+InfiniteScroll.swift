//
//  CommunitiesList+InfiniteScroll.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.05.2022.
//

import UIKit
import Models

extension CommunitiesListViewController {
    func add(
        items: [CommunityResponse],
        animation: UITableView.RowAnimation
    ) {
        guard let section = sections.firstIndex(where: { $0.section == .communities }) else { return }
        let oldCount = self.communities.count
        self.communities.append(contentsOf: items)
        let newCount = self.communities.count
        let indexPaths = (oldCount..<newCount).map { IndexPath(row: $0, section: section)}
        mainView.beginUpdates()
        mainView.insertRows(at: indexPaths, with: animation)
        mainView.endUpdates()
    }
}
