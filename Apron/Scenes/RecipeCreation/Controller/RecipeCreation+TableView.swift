//
//  RecipeCreation+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.04.2022.
//

import Foundation
import UIKit
import Models

extension RecipeCreationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
}

extension RecipeCreationViewController:
    UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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
            return 100 + CGFloat((recipeCreation?.ingredients?.count ?? 0) * 46)
        case .instruction:
            return 100 + CGFloat((recipeCreation?.instructions?.count ?? 0) * 80)
        case .servings:
            return 80
        case .prepTime:
            return 80
        case .cookTime:
            return 80
        default:
            return 600
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
            return 100 + CGFloat((recipeCreation?.ingredients?.count ?? 0) * 46)
        case .instruction:
            return 100 + CGFloat((recipeCreation?.instructions?.count ?? 0) * 80)
        case .servings:
            return 80
        case .prepTime:
            return 80
        case .cookTime:
            return 80
        default:
            return 600
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            guard let cell = cell as? RecipeCreationNamingCell else { return }
            cell.delegate = self
            cell.configure(recipeName: recipeCreation?.recipeName)
        case .image:
            guard let cell = cell as? RecipeCreationImageCell else { return }
            cell.delegate = self
            cell.configure(image: selectedImage, imageURL: recipeCreation?.imageURL)
        case .imagePlaceholder:
            guard let cell = cell as? RecipeCreationPlaceholderImageCell else { return }
            cell.delegate = self
            cell.configure()
        case .description:
            guard let cell = cell as? RecipeCreationDescriptionCell else  { return }
            cell.delegate = self
            cell.placeholder = "Напишете описание вашего блюда"
            cell.configure(description: recipeCreation?.description)
        case .composition:
            guard let cell = cell as? RecipeCreationAddIngredientCell else { return }
            cell.configure(ingredients: recipeCreation?.ingredients, newIngredientDelegate: self)
        case .instruction:
            guard let cell = cell as? RecipeCreationAddInstructionCell else { return }
            cell.configure(instructions: recipeCreation?.instructions, newInstructionDelegate: self)
        case .servings:
            guard let cell = cell as? RecipeCreationAssignCell else { return }
            cell.delegate = self
            cell.configure(type: .servings(recipeCreation?.servings ?? ""))
        case .prepTime:
            guard let cell = cell as? RecipeCreationAssignCell else { return }
            cell.delegate = self
            cell.configure(type: .prepTime(recipeCreation?.prepTime ?? ""))
        case .cookTime:
            guard let cell = cell as? RecipeCreationAssignCell else { return }
            cell.delegate = self
            cell.configure(type: .cookTime(recipeCreation?.cookTime ?? ""))
        default: break
        }
    }
}
