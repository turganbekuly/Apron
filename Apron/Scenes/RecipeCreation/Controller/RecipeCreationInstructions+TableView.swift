//
//  RecipeCreationInstructions+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.08.2022.
//

import Foundation
import UIKit
import Models
import APRUIKit

extension RecipeCreationAddInstructionCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructionsSections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case .instruction:
            let cell: RecipeCreationInstructionViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension RecipeCreationAddInstructionCell:
    UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .instruction(instruction):
            let width = (UIScreen.main.bounds.width - 60)
            return instruction.height(constraintedWidth: width, font: TypographyFonts.semibold12) + 40
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .instruction(instruction):
            let width = (UIScreen.main.bounds.width - 60)
            return instruction.height(constraintedWidth: width, font: TypographyFonts.semibold12) + 40
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .instruction(instruction):
            guard let cell = cell as? RecipeCreationInstructionViewCell else { return }
            cell.configure(instruction: instruction, stepCount:  "\(indexPath.row + 1)")
        }
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .instruction(instruction):
            let action = UIContextualAction(
                style: .normal,
                title: "") { [weak self] action, view, completion in
                    guard let self = self else { return }
//                    self.cartItems.remove(at: indexPath.row)
//                    self.removeCartItem(with: item.productName, measurement: item.measurement)
                    completion(true)
                }
            action.image = ApronAssets.trashIcon.image
            action.backgroundColor = ApronAssets.secondary.color
            return UISwipeActionsConfiguration(actions: [action])
        }
    }
}

