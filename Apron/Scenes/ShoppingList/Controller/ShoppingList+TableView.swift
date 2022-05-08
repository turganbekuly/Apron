//
//  ShoppingList+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension ShoppingListViewController: UITableViewDataSource {
    
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
        case .loading:
            let cell: EmptyCartCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .ingredient:
            let cell: ShoppingItemCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension ShoppingListViewController: UITableViewDelegate {
    
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
        case .loading:
            return 230
        case .ingredient:
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .loading:
            return 230
        case .ingredient:
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .loading:
            guard let cell = cell as? EmptyCartCell else { return }
        case let .ingredient(item):
            guard let cell = cell as? ShoppingItemCell else { return }
            cell.configure(item: item)
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let section = sections[section].section
//        switch section {
//        default:
//            break
//        }
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        let section = sections[section].section
//        switch section {
//        default:
//            break
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let section = sections[section].section
//        switch section {
//        default:
//            break
//        }
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let section = sections[section].section
//        switch section {
//        default:
//            break
//        }
//    }
    
}
