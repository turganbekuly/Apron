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
            let .mealPlan(type):
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
                image: ApronAssets.communityPrivateIcon.image,
                title: "Создать закрытое сообщество",
                subtitle: "Присоединиться могут только люди, которых вы пригласили"
            ))
        case .publicCommunity:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: ApronAssets.communityPublicIcon.image,
                title: "Создать публичное сообщество",
                subtitle: "Любой может просматривать и присоединяться"
            ))
        case .aboutCommunities:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: ApronAssets.communityAboutIcon.image,
                title: "Подробнее о сообществах",
                subtitle: nil
            ))
        case .savedRecipe:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: ApronAssets.recipeAddIcon.image,
                title: "Добавить сохраненный рецепт",
                subtitle: nil
            ))
        case .newRecipe:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: ApronAssets.recipeNewIcon.image,
                title: "Создать новый рецепт",
                subtitle: nil
            ))
        case .shoppingList:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: ApronAssets.tabListIcon.image,
                title: "Добавить в список покупок"
            ))
        default:
            break
        }
    }
}
