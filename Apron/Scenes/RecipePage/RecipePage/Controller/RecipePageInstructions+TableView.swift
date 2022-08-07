//
//  RecipePageInstructions+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.08.2022.
//

import Foundation
import UIKit
import Models
import APRUIKit

extension RecipeInstructionsViewCell: UITableViewDataSource {
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

extension RecipeInstructionsViewCell:
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
}

