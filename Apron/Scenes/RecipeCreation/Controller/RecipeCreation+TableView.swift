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
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case is RecipeCreationView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case .image:
                let cell: RecipeCreationImageCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .imagePlaceholder:
                let cell: RecipeCreationPlaceholderImageCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .description:
                let cell: RecipeCreationDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .composition:
                let cell: RecipeCreationAddIngredientCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .instruction:
                let cell: RecipeCreationAddInstructionCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .servings:
                let cell: RecipeCreationAssignCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .prepTime:
                let cell: RecipeCreationAssignCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .cookTime:
                let cell: RecipeCreationAssignCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            default:
                let cell: RecipeCreationNamingCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            }
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
        case is RecipeCreationView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case .name:
                return 54
            case .image:
                return 221
            case .imagePlaceholder:
                return 167
            case .description:
                return 125
            case .composition:
                return 86
            case .instruction:
                return 86
            case .servings:
                return 70
            case .prepTime:
                return 70
            case .cookTime:
                return 70
            default:
                return 600
            }
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
        case is RecipeCreationView:
            let row = sections[indexPath.section].rows[indexPath.row]
            switch row {
            case .name:
                guard let cell = cell as? RecipeCreationNamingCell else { return }
                cell.configure()
            case .image:
                guard let cell = cell as? RecipeCreationImageCell else { return }
                cell.configure()
            case .imagePlaceholder:
                guard let cell = cell as? RecipeCreationPlaceholderImageCell else { return }
                cell.configure()
            case .description:
                guard let cell = cell as? RecipeCreationDescriptionCell else  { return }
                cell.configure()
            case .composition:
                guard let cell = cell as? RecipeCreationAddIngredientCell else { return }
                cell.configure(delegate: self, newIngredientDelegate: self)
            case .instruction:
                guard let cell = cell as? RecipeCreationAddInstructionCell else { return }
                cell.configure(delegate: self)
            case .servings:
                guard let cell = cell as? RecipeCreationAssignCell else { return }
                cell.configure(type: .servings)
            case .prepTime:
                guard let cell = cell as? RecipeCreationAssignCell else { return }
                cell.configure(type: .prepTime)
            case .cookTime:
                guard let cell = cell as? RecipeCreationAssignCell else { return }
                cell.configure(type: .cookTime)
            default: break
            }
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
