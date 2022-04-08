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
        case .ingredient:
            let cell: RecipeIngredientsViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .instruction:
            let cell: RecipeInstructionsViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RecipePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return (view.bounds.width / 2) + 130
        case .ingredient:
            return CGFloat(54 + ((ingredients.first?.ingredients.count ?? 1) * 38))
        case .instruction:
            return CGFloat(84 + (steps.first?.instructions.count ?? 1) * 95)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .topView:
            return (view.bounds.width / 2) + 130
        case .ingredient:
            return CGFloat(54 + ((ingredients.first?.ingredients.count ?? 1) * 38))
        case .instruction:
            return CGFloat(84 + (steps.first?.instructions.count ?? 1) * 95)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .topView(info):
            guard let cell = cell as? RecipeInformationViewCell else { return }
            cell.onEditButtonTapped = {
                let viewController = RecipeCreationBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            cell.configure(with: info)
        case let .ingredient(ingredient):
            guard let cell = cell as? RecipeIngredientsViewCell else { return }
            cell.configure(with: ingredient)
        case let .instruction(instruction):
            guard let cell = cell as? RecipeInstructionsViewCell else { return }
            cell.configure(with: instruction)
        }
    }
}
