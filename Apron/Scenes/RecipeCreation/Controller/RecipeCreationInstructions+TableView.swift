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
import Extensions

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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .instruction(instruction):
            newInstructionDelegate?.onInstructionTapped(instruction: instruction, step: indexPath.row + 1)
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .instruction(instruction):
            let width = (UIScreen.main.bounds.width - 60)
            var imageHeight: CGFloat = 0
            if let _ = instruction.image {
                imageHeight = 220
            }
            return (instruction.description?.heightLabel(constraintedWidth: width, font: TypographyFonts.semibold12) ?? 10) + 40 + imageHeight
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = instructionsSections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .instruction(instruction):
            let width = (UIScreen.main.bounds.width - 60)
            var imageHeight: CGFloat = 0
            if let _ = instruction.image {
                imageHeight = 220
            }
            return (instruction.description?.heightLabel(constraintedWidth: width, font: TypographyFonts.semibold12) ?? 10) + 40 + imageHeight
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
                title: ""
            ) { [weak self] action, view, completion in
                    guard let self = self else { return }
                self.newInstructionDelegate?.remove(instruction: instruction)
                    completion(true)
                }
            action.image = ApronAssets.trashIcon.image
            action.backgroundColor = ApronAssets.secondary.color
            return UISwipeActionsConfiguration(actions: [action])
        }
    }
}

