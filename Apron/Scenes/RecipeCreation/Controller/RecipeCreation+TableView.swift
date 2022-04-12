//
//  RecipeCreation+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.04.2022.
//

import Foundation
import UIKit

extension RecipeCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case is RecipeCreationIngredientsView:
            let cell: RecipeCreationIngredientCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RecipeCreationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case is RecipeCreationIngredientsView:
            let row = ingredientSections[indexPath.section].rows[indexPath.row]
            switch row {
            case .ingredient:
                return 38
            }
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case is RecipeCreationIngredientsView:
            let row = ingredientSections[indexPath.section].rows[indexPath.row]
            switch row {
            case .ingredient:
                return 38
            }
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch tableView {
        case is RecipeCreationIngredientsView:
            let row = ingredientSections[indexPath.section].rows[indexPath.row]
            switch row {
            case let .ingredient(ingredient):
                guard let cell = cell as? RecipeCreationIngredientCell else { return }
                cell.configure(with: ingredient)
            }
        default:
            break
        }
    }
}
