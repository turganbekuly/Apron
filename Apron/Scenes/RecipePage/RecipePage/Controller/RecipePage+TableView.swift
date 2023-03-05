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
import Extensions

extension RecipePageViewController {
    enum CalculatorType {
        case proteinCount(ingredient: RecipeIngredient)
        case fatCount(ingredient: RecipeIngredient)
        case carbsCount(ingredient: RecipeIngredient)
        case ccalCount(ingredient: RecipeIngredient)
    }
    func calculateCalories(type: CalculatorType) -> Double {
        switch type {
        case .proteinCount(let ingredient):
            return (((ingredient.product?.proteinMass ?? 0) * (ingredient.amount ?? 0)) / 100)
        case .fatCount(let ingredient):
            return (((ingredient.product?.fatMass ?? 0) * (ingredient.amount ?? 0)) / 100)
        case .carbsCount(let ingredient):
            return (((ingredient.product?.carbsMass ?? 0) * (ingredient.amount ?? 0)) / 100)
        case .ccalCount(let ingredient):
            return (((ingredient.product?.kilokalori ?? 0) * (ingredient.amount ?? 0)) / 100)
        }
    }
}

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
        case .reworkInfo:
            let cell: RecipeReworkInfoViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
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
        case .reworkInfo:
            guard let reworkInfo = recipe?.reworkInfo else { return 0 }
            let width = (UIScreen.main.bounds.width - 32)
            var text = "Замечания от модератора:\n"
            for (index, reason) in reworkInfo.enumerated() {
                if index == 0 {
                    text += reason
                } else {
                    text += "\n \(reason)"
                }
            }
            return 16 + text.heightLabel(constraintedWidth: width, font: TypographyFonts.regular14)
        case .topView:
            return (mainView.bounds.width / 1.5) + 80
        case .description:
            let width = (UIScreen.main.bounds.width - 32)
            return 50 + (recipe?.description?.heightLabel(constraintedWidth: width, font: TypographyFonts.regular14) ?? 0)
        case .ingredient:
            return CGFloat(185 + ((recipe?.ingredients?.count ?? 1) * 55))
        case .nutrition:
            return 203
        case .instruction:
            var imageSize: CGFloat = 0
            let width = (UIScreen.main.bounds.width - 60)

            if let images = recipe?.instructions?.compactMap({ $0.image }), images.count != 0 {
                imageSize = CGFloat(images.count) * 220
            }

            return 160 + imageSize + ((recipe?.instructions?
                .reduce(
                    0, {
                        $0 + (
                            (
                                $1.description?.heightLabel(constraintedWidth: width, font: TypographyFonts.semibold14) ?? 10
                            ) + 37
                        )
                    }
                ) ?? 56))
        case let .review(comment):
            let width = (UIScreen.main.bounds.width - 85)
            return 45 + Typography.regular14(text: comment.description ?? "").styled.height(containerWidth: width) + (ceil(CGFloat(comment.tags?.count ?? 1) / 2) * 32)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .reworkInfo:
            guard let reworkInfo = recipe?.reworkInfo else { return 0 }
            let width = (UIScreen.main.bounds.width - 32)
            var text = "Замечания от модератора:\n"
            for (index, reason) in reworkInfo.enumerated() {
                if index == 0 {
                    text += reason
                } else {
                    text += "\n \(reason)"
                }
            }
            return 16 + text.heightLabel(constraintedWidth: width, font: TypographyFonts.regular14)
        case .topView:
            return (mainView.bounds.width / 1.5) + 80
        case .description:
            let width = (UIScreen.main.bounds.width - 32)
            return 50 + (recipe?.description?.heightLabel(constraintedWidth: width, font: TypographyFonts.regular14) ?? 0)
        case .ingredient:
            return CGFloat(185 + ((recipe?.ingredients?.count ?? 1) * 55))
        case .nutrition:
            return 203
        case .instruction:
            var imageSize: CGFloat = 0
            let width = (UIScreen.main.bounds.width - 60)

            if let images = recipe?.instructions?.compactMap({ $0.image }), images.count != 0 {
                imageSize = CGFloat(images.count) * 220
            }

            return 160 + imageSize + ((recipe?.instructions?
                .reduce(
                    0, {
                        $0 + (
                            (
                                $1.description?.heightLabel(constraintedWidth: width, font: TypographyFonts.semibold14) ?? 10
                            ) + 35
                        )
                    }
                ) ?? 56))
        case let .review(comment):
            let width = (UIScreen.main.bounds.width - 85)
            let imageHeight: CGFloat = comment.image != nil && comment.image?.isEmpty == false ? 100 : 0
            let descriptionHeight = Typography.regular14(text: comment.description ?? "").styled.height(containerWidth: width)
            let tagsHeight = (ceil(CGFloat(comment.tags?.count ?? 1) / 2) * 32)
            return 45 + descriptionHeight + tagsHeight + imageHeight
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .reworkInfo:
            guard let cell = cell as? RecipeReworkInfoViewCell else { return }
            cell.configure(reworkInfo: recipe?.reworkInfo ?? [])
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
                    activityItems: [
                        "Зацените рецепт \"\(self.recipe?.recipeName ?? "")\" на Moca.kz 👀\n moca.kz://main/recipe/\(self.recipe?.id ?? 0)"
                    ],
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
                dislikeCount: recipe?.dislikesCount ?? 0
            ))
        case .description:
            guard let cell = cell as? IngredientDescriptionCell else { return }
            cell.configure(with: IngredientsDescriptionCellViewModel(
                description: recipe?.description ?? "",
                cookingTime: "\(recipe?.cookTime ?? 0)"
            ))
        case .ingredient:
            guard let cell = cell as? RecipeIngredientsViewCell else { return }
            cell.onAddToCartTapped = { [weak self] in
                guard let self = self else { return }
                self.handleAddToCart(ingredients: self.recipe?.ingredients)
            }
            cell.configure(with: IngredientsListCellViewModel(
                serveCount: recipe?.servings ?? 1,
                ingredients: recipe?.ingredients ?? []
            ))
        case .nutrition:
            guard let cell = cell as? RecipeCaloriesViewCell else { return }
            let ingredients = self.recipe?.ingredients
            cell.configure(with: CaloriesCellViewModel(
                proteinCount: ingredients?.reduce(0, { $0 + calculateCalories(type: .proteinCount(ingredient: $1)) }),
                fatCount: ingredients?.reduce(0, { $0 + calculateCalories(type: .fatCount(ingredient: $1)) }),
                carbsCount: ingredients?.reduce(0, { $0 + calculateCalories(type: .carbsCount(ingredient: $1)) }),
                ccalCount: ingredients?.reduce(0, { $0 + calculateCalories(type: .ccalCount(ingredient: $1)) })
            ))
        case .instruction:
            guard let cell = cell as? RecipeInstructionsViewCell else { return }
            cell.configure(with: InstructionCellViewModel(
                instructions: recipe?.instructions ?? []
            ))
            cell.onCookModeTapped = { [weak self] in
                guard let self = self,
                      let instructions = self.recipe?.instructions,
                      !instructions.isEmpty
                else { return }
                let vc = StepByStepModeBuilder(state: .initial(instructions, self.recipe?.imageURL, self)).build()
                let navController = StepNavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.navigationController?.present(navController, animated: true)
                }
            }
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
