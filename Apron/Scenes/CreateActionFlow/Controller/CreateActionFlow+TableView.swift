//
//  CreateActionFlow+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit

extension CreateActionFlowViewController: UITableViewDataSource {

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
        default:
            let cell: CreateButtonCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension CreateActionFlowViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .privateCommunity(type),
            let .publicCommunity(type),
            let .aboutCommunities(type),
            let .savedRecipe(type),
            let .newRecipe(type),
            let .recipeAddTo(type),
            let .recipeShare(type),
            let .recipeSave(type),
            let .recipeReportType(type),
            let .reportRecipe(type),
            let .reportUser(type),
            let .shareCommunity(type),
            let .reportCommunity(type),
            let .shoppingList(type),
            let .mealPlan(type),
            let .clearIngredients(type),
            let .shareIngredients(type):
            dismiss(animated: true) {
                self.delegate?.handleChosenAction(type: type)
            }
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .aboutCommunities, .savedRecipe, .newRecipe:
            return 40
        default:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .aboutCommunities, .savedRecipe, .newRecipe:
            return 40
        default:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .privateCommunity:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.communityPrivateIcon.image,
                title: L10n.CreateActionFlow.PrivateCommunity.title,
                subtitle: L10n.CreateActionFlow.PrivateCommunity.subtitle
            ))
        case .publicCommunity:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.communityPublicIcon.image,
                title: L10n.CreateActionFlow.PublicCommunity.title,
                subtitle: L10n.CreateActionFlow.PublicCommunity.subtitle
            ))
        case .aboutCommunities:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.communityAboutIcon.image,
                title: L10n.CreateActionFlow.AboutCommunities.title,
                subtitle: nil
            ))
        case .savedRecipe:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.recipeAddIcon.image,
                title: L10n.CreateActionFlow.SavedRecipe.title,
                subtitle: nil
            ))
        case .newRecipe:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.recipeNewIcon.image,
                title: L10n.CreateActionFlow.NewRecipe.title,
                subtitle: nil
            ))
        case .shoppingList:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.tabListIcon.image,
                title: L10n.CreateActionFlow.ShoppingList.title
            ))
        case .shareIngredients:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.recipeShareIcon.image,
                title: L10n.CreateActionFlow.ShareIngredients.title
            ))
        case .shareCommunity:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.recipeShareIcon.image,
                title: L10n.CreateActionFlow.ShareCommunity.title
            ))
        case .clearIngredients:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: APRAssets.trashIcon.image,
                title: L10n.CreateActionFlow.ClearIngredients.title
            ))
        default:
            break
        }
    }
}
