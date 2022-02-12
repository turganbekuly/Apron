//
//  IngredientsPage+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension IngredientsPageViewController: UITableViewDataSource {
    
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
        case .description:
            let cell: IngredientDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .ingredients:
            let cell: IngredientsListCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension IngredientsPageViewController: UITableViewDelegate {
    
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
        case .description:
            return 100
        case .ingredients:
            return 500
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .description:
            return 100
        case .ingredients:
            return 500
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .description(description):
            guard let cell = cell as? IngredientDescriptionCell else { return }
            cell.configure(with: description)
        case let .ingredients(ingredients):
            guard let cell = cell as? IngredientsListCell else { return }
            cell.configure(with: ingredients)
        }
    }
}
