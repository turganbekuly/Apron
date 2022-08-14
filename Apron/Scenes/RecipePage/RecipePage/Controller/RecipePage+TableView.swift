//
//  RecipePage+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.02.2022.
//

import Foundation
import UIKit
import Models
import APRUIKit

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
        case .review:
            let cell: RecipeReviewsCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RecipePageViewController: UITableViewDelegate {

    func textHeight(withWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        return textSize(font: font, text: text, width: width).height
    }

    func textWidth(font: UIFont, text: String) -> CGFloat {
        return textSize(font: font, text: text).width
    }

    func textSize(font: UIFont, text: String, width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size
    }

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
            let width = (UIScreen.main.bounds.width - 32)
            return 50 + (recipe?.description?.height(constraintedWidth: width, font: TypographyFonts.regular12) ?? 50)
        case .ingredient:
            return CGFloat(133 + ((recipe?.ingredients?.count ?? 1) * 45))
        case .nutrition:
            return 203
        case .instruction:
            let width = (UIScreen.main.bounds.width - 60)
            return 60 + ((recipe?.instructions?
                .reduce(0, {
                    $0 + ($1.height(constraintedWidth: width, font: TypographyFonts.semibold12) + 60)
                }) ?? 56))
        case let .review(comment):
            let width = (UIScreen.main.bounds.width - 85)
            return 45 + Typography.regular14(text: comment.description ?? "").styled.height(containerWidth: width) + (ceil(CGFloat(comment.tags?.count ?? 1) / 2) * 32)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return (view.bounds.width / 2) + 120
        case .description:
            let width = (UIScreen.main.bounds.width - 32)
            return 50 + (recipe?.description?.height(constraintedWidth: width, font: TypographyFonts.regular12) ?? 50)
        case .ingredient:
            return CGFloat(133 + ((recipe?.ingredients?.count ?? 1) * 45))
        case .nutrition:
            return 203
        case .instruction:
            let width = (UIScreen.main.bounds.width - 60)
            return 60 + ((recipe?.instructions?
                .reduce(0, {
                    $0 + ($1.height(constraintedWidth: width, font: TypographyFonts.semibold12) + 60)
                }) ?? 56))
        case let .review(comment):
            let width = (UIScreen.main.bounds.width - 85)
            return 45 + Typography.regular14(text: comment.description ?? "").styled.height(containerWidth: width) + (ceil(CGFloat(comment.tags?.count ?? 1) / 2) * 32)
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
            cell.onShareButtonTapped = { [weak self] in
                guard let self = self else { return }
                let viewController = UIActivityViewController(
                    activityItems: ["https://apron.ws/recipe/\(self.recipe?.id ?? 0)"],
                    applicationActivities: nil
                )

                if let popoover = viewController.popoverPresentationController {
                    popoover.sourceView = self.view
                    popoover.sourceRect = self.view.bounds
                    popoover.permittedArrowDirections = []
                }

                self.navigationController?.present(viewController, animated: true, completion: nil)
            }
            cell.configure(with: InformationCellViewModel(
                recipeName: recipe?.recipeName ?? "",
                recipeImage: recipe?.imageURL ?? "",
                recipeSourceURL: recipe?.sourceName,
                likeCount: recipe?.likesCount ?? 0,
                dislikeCount: recipe?.likesCount ?? 0
            ))
        case .description:
            guard let cell = cell as? IngredientDescriptionCell else { return }
            cell.configure(with: IngredientsDescriptionCellViewModel(
                description: recipe?.description ?? "",
                cookingTime: "\(recipe?.cookTime ?? 0)"
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
        case let .review(comment):
            guard let cell = cell as? RecipeReviewsCell else { return }
            cell.configure(with: RecipePageReviewsViewModel(comment: comment))
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .reviews:
            let view: RecipeReviewsHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .reviews:
            return 54
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .reviews:
            return 54
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .reviews:
            guard let view = view as? RecipeReviewsHeaderView, !recipeComments.isEmpty else { return }
            view.configure(title: "Отзывы")
        default:
            break
        }
    }
}
