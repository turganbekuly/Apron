//
//  RecipePage+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.02.2022.
//

import Foundation
import UIKit
import Models

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
        case .description:
            let cell: IngredientDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .ingredient:
            let cell: RecipeIngredientsViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .nutrition:
            let cell: RecipeCaloriesViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .instruction:
            let cell: RecipeInstructionsViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RecipePageViewController: UITableViewDelegate {
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
        case .topView:
            return (view.bounds.width / 2) + 120
        case .description:
            return 80
        case .ingredient:
            return CGFloat(133 + ((recipe?.ingredients?.count ?? 1) * 38))
        case .nutrition:
            return 203
        case .instruction:
            return CGFloat(84 + (recipe?.instructions?.count ?? 1) * 95)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return (view.bounds.width / 2) + 120
        case .description:
            return 80
        case .ingredient:
            return CGFloat(133 + ((recipe?.ingredients?.count ?? 1) * 38))
        case .nutrition:
            return 203
        case .instruction:
            return CGFloat(84 + (recipe?.instructions?.count ?? 1) * 95)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            guard let cell = cell as? RecipeInformationViewCell else { return }
            cell.onEditButtonTapped = {
                guard
                    let recipe = self.recipe,
                    let recipeCreation = RecipeCreation(from: recipe) else { return }

                let viewController = RecipeCreationBuilder(
                    state: .initial(.edit(recipeCreation, .recipe))).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            cell.configure(with: InformationCellViewModel(
                recipeName: recipe?.recipeName ?? "",
                recipeSourceURL: recipe?.sourceName
            ))
        case .description:
            guard let cell = cell as? IngredientDescriptionCell else { return }
            cell.configure(with: IngredientsDescriptionCellViewModel(
                description: recipe?.description ?? "",
                cookingTime: recipe?.cookTime ?? "30"
            ))
        case .ingredient:
            guard let cell = cell as? RecipeIngredientsViewCell else { return }
            cell.configure(with: IngredientsListCellViewModel(
                serveCount: recipe?.servings ?? 1,
                ingredients: recipe?.ingredients ?? []
            ))
        case .nutrition:
            guard let cell = cell as? RecipeCaloriesViewCell else { return }
            let ingredients = self.recipe?.ingredients
            cell.configure(with: CaloriesCellViewModel(
                proteinCount: ingredients?.reduce(0, { $0 + ($1.product?.proteinMass ?? 0) }),
                fatCount: ingredients?.reduce(0, { $0 + ($1.product?.fatMass ?? 0) }),
                carbsCount: ingredients?.reduce(0, { $0 + ($1.product?.carbsMass ?? 0) }),
                ccalCount: ingredients?.reduce(0, { $0 + ($1.product?.kilokalori ?? 0) })
            ))
        case .instruction:
            guard let cell = cell as? RecipeInstructionsViewCell else { return }
            cell.configure(with: InstructionCellViewModel(
                instructions: recipe?.instructions ?? []
            ))
        }
    }
}
