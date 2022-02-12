//
//  RecipePage+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.02.2022.
//

import Foundation
import UIKit

extension RecipePageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            let cell: RecipeInformationViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .page:
            let cell: RecipePagesViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RecipePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return 320
        case .page:
            return 1000
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return 320
        case .page:
            return 1000
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .topView(info):
            guard let cell = cell as? RecipeInformationViewCell else { return }
            cell.configure(with: info)
        case .page:
            guard let cell = cell as? RecipePagesViewCell else { return }
            cell.addChildViewController(
                viewController: pagerViewController,
                to: self
            )
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .topView:
            return UIView()
        case .pages:
            let view: SegmentedTableHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .topView:
            return 0
        case .pages:
            return 34
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .topView:
            return 0
        case .pages:
            return 34
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .topView:
            break
        case .pages:
            guard let view = view as? SegmentedTableHeaderView else { return }
            view.delegate = self
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        pagerViewController.removeFromParent()
        pagerViewController.view.removeFromSuperview()
    }
}
