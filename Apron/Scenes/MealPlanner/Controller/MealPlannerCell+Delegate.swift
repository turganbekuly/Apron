//
//  MealPlannerCell+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.02.2023.
//

import Foundation
import Extensions

extension MealPlannerCell: MealPlannerCollectionCellProtocol {
    func removeRecipe(with id: Int, with weekDay: MealPlannerWeekDays) {
        delegate?.removeRecipe(with: id, with: weekDay)
    }
    
    func openRecipe(with id: Int) {
        delegate?.openRecipe(with: id)
    }
}
