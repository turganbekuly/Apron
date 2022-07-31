//
//  PreShoppingList+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension PreShoppingListViewController: UITableViewDataSource {
    
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
        case .ingredient:
            let cell: PreShoppingCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension PreShoppingListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .ingredient(ingredient):
            guard let cell = tableView.cellForRow(at: indexPath) as? PreShoppingCell else { return }
            if cell.checkbox.checkState == .checked  {
                selectedItems.append(ingredient)
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .ingredient(ingredient):
            guard let cell = tableView.cellForRow(at: indexPath) as? PreShoppingCell else { return }
            if cell.checkbox.checkState == .unchecked {
                selectedItems.removeAll(where: { $0 == ingredient })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .ingredient:
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .ingredient:
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .ingredient(ingredient):
            guard let cell = cell as? PreShoppingCell else { return }
            cell.configure(ingredient: ingredient)
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
}
