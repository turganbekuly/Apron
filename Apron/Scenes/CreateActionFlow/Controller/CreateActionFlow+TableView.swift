//
//  CreateActionFlow+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import DesignSystem

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
        case let .aboutCommunities(type),
            let .newRecipe(type),
            let .privateCommunity(type),
            let .publicCommunity(type),
            let .savedRecipe(type),
            let .shoppingList(type):
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
                image: Assets.communityPrivateIcon.image,
                title: "Создать закрытое сообщество",
                subtitle: "Присоединиться могут только люди, которых вы пригласили"
            ))
        case .publicCommunity:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: Assets.communityPublicIcon.image,
                title: "Создать публичное сообщество",
                subtitle: "Любой может просматривать и присоединяться"
            ))
        case .aboutCommunities:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: Assets.communityAboutIcon.image,
                title: "Подробнее о сообществах",
                subtitle: nil
            ))
        case .savedRecipe:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: Assets.recipeAddIcon.image,
                title: "Добавить сохраненный рецепт",
                subtitle: nil
            ))
        case .newRecipe:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: Assets.recipeNewIcon.image,
                title: "Создать новый рецепт",
                subtitle: nil
            ))
        case .shoppingList:
            guard let cell = cell as? CreateButtonCell else { return }
            cell.configure(with: CreateButtonCellViewModel(
                image: Assets.tabListIcon.image,
                title: "Добавить в список покупок"
            ))
        }
    }
}
