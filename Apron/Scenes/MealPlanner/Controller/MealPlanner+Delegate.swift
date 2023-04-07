//
//  MealPlanner+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.02.2023.
//

import Foundation
import Extensions
import AlertMessages

extension MealPlannerViewController: MealPlannerCellProtocol {
    func removeRecipe(with id: Int, with weekDay: MealPlannerWeekDays) {
        self.addingDay = weekDay
        guard let day = addingDay else { return }
        let recipeDate = CalendarHelper().weekDayFromType(day, start: startDate, end: endDate)
        let yesAction = AlertActionInfo(
            title: "Удалить",
            type: .destructive
        ) {
            self.isLoadingButton(true)
            self.removeRecipe(recipeId: id, date: self.dateConverter(date: recipeDate))
        }

        let noAction = AlertActionInfo(
            title: "Отменить",
            type: .cancel
        ) {
            self.dismiss(animated: true)
        }

        showAlert(
            "Вы уверены?",
            message: "Этот рецепт будет удален из вашего плана питания.",
            actions: [noAction, yesAction]
        )
    }
}
