//
//  ShoppingList+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit
import Alamofire
import Storages

extension ShoppingListViewController: UITableViewDataSource {

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
        case .empty:
            let cell: EmptyListTableCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .ingredient:
            let cell: ShoppingItemCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension ShoppingListViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .ingredient(item):
            let action = UIContextualAction(
                style: .normal,
                title: "") { [weak self] _, _, completion in
                    guard let self = self else { return }
                    self.cartItems.remove(at: indexPath.row)
                    self.removeCartItem(with: item.productName, measurement: item.measurement)
                    completion(true)
                }
            action.image = ApronAssets.trashIcon.image
            action.backgroundColor = ApronAssets.secondary.color
            return UISwipeActionsConfiguration(actions: [action])
        default:
            return .none
        }
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .ingredient(item):
            guard let cartItem = cartItems.first(where: { $0.productName == item.productName }) else { return }
            var bought = cartItem.bought
            if cartItem.bought {
                bought = false
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                bought = true
            }

            CartManager.shared.update(
                productId: cartItem.productId,
                productName: cartItem.productName,
                productCategoryName: cartItem.productCategoryName,
                productImage: cartItem.productImage,
                amount: cartItem.amount,
                measurement: cartItem.measurement,
                recipeName: cartItem.recipeName?.first,
                bought: bought
            )
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .empty:
            return 230
        case .ingredient:
            return 90
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .empty:
            return 230
        case .ingredient:
            return 90
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .empty:
            guard let cell = cell as? EmptyListTableCell else { return }
            cell.configure(
                with: "Добавьте товары в свой список покупок",
                image: ApronAssets.emptyCart.image
            )
        case let .ingredient(item):
            guard let cell = cell as? ShoppingItemCell else { return }
            cell.delegate = self
            cell.configure(item: item)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .ingredients, .checkedIngredients:
            let view: ShoppingListHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .ingredients, .checkedIngredients:
            return 30
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .ingredients, .checkedIngredients:
            return 30
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .ingredients:
            guard let view = view as? ShoppingListHeaderView else { return }
            view.configure(title: "Ингредиенты")
        case .checkedIngredients:
            guard let view = view as? ShoppingListHeaderView else { return }
            view.configure(title: "Купленные ингредиенты")
        }
    }
}
