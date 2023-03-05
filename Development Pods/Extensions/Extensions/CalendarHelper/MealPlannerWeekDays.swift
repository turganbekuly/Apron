//
//  MealPlannerWeekDays.swift
//  Models
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation

public enum MealPlannerWeekDays: Int, Codable {
    case sunday = 0
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    public var title: String? {
        switch self {
        case .monday:
            return "Понедельник"
        case .tuesday:
            return "Вторник"
        case .wednesday:
            return "Среда"
        case .thursday:
            return "Четверг"
        case .friday:
            return "Пятница"
        case .saturday:
            return "Суббота"
        case .sunday:
            return "Воскресенье"
        }
    }
}
