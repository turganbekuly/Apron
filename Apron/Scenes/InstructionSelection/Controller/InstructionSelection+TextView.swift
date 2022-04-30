//
//  InstructionSelection+TextView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30.04.2022.
//

import Foundation

extension InstructionSelectionViewController: DescriptionCellDelegate {
    func cell(_ cell: RecipeCreationDescriptionCell, didEnteredDesc descr: String?) {
        self.instructionDesc = descr
    }
}
