//
//  MealPlanner+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.02.2023.
//

import Foundation
import Extensions
import AlertMessages
import APRUIKit

extension MealPlannerViewController: MealPlannerCellProtocol {
    func removeRecipe(with id: Int, with weekDay: MealPlannerWeekDays) {
        self.addingDay = weekDay
        guard let day = addingDay else { return }
        let recipeDate = CalendarHelper().weekDayFromType(day, start: startDate, end: endDate)
        let yesAction = AlertActionInfo(
            title: L10n.Common.Delete.title,
            type: .destructive
        ) {
            self.isLoadingButton(true)
            self.removeRecipe(recipeId: id, date: self.dateConverter(date: recipeDate))
        }

        let noAction = AlertActionInfo(
            title: L10n.Common.сancelTwo,
            type: .cancel
        ) {
            self.dismiss(animated: true)
        }

        showAlert(
            L10n.MealPlanner.areYouSure,
            message: L10n.MealPlanner.willBeDeletedFromYourPlan,
            actions: [noAction, yesAction]
        )
    }
    
    func openRecipe(with id: Int) {
        let viewController = RecipePageBuilder(state: .initial(id: id, .mealPlanner)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}
