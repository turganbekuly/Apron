//
//  RecipeCreation+PaidCells.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.10.2022.
//

import Foundation
import UIKit

extension RecipeCreationViewController: RecipeCreationPaidCellProtocol {
    func cell(valueChangedSwitch switcher: UISwitch) {
        if switcher.isOn {
            addPaidInfoCell()
        } else {
            removePaidInfoCell()
        }
    }

    private func addPaidInfoCell() {
        guard
            let section = sections.firstIndex(where: { $0.section == .info }),
            let row = sections[section].rows.firstIndex(where: { $0 == .paidRecipe })
        else { return }

        mainView.beginUpdates()
        mainView.insertRows(at: [.init(row: row + 1, section: section)], with: .fade)
        sections[section].rows.insert(.paidRecipeInfo, at: row + 1)
        mainView.endUpdates()
    }

    private func removePaidInfoCell() {
        guard
            let section = sections.firstIndex(where: { $0.section == .info }),
            let row = sections[section].rows.firstIndex(where: { $0 == .paidRecipeInfo })
        else { return }

        mainView.beginUpdates()
        mainView.deleteRows(at: [.init(row: row, section: section)], with: .fade)
        sections[section].rows.remove(at: row)
        mainView.endUpdates()
    }
}

extension RecipeCreationViewController: RecipeCreationPaidInfoCellProtocol {
    func cell(didEnteredEmail email: String?) {
        recipeCreation?.email = email
    }

    func cell(didEnteredPromo promo: String?) {
        recipeCreation?.promo = promo
    }
}
