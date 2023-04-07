//
//  CalendarHelper.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation
import UIKit

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}

extension Date {
    static public func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

public final class CalendarHelper {
    // MARK: - Private property

    var calendar = Calendar.current

    // MARK: - Public init

    public init() {
        calendar.firstWeekday = 2
    }

    // MARK: - Public methods

    public func plusMonth(date: Date) -> Date? {
        return calendar.date(byAdding: .month, value: 1, to: date)
    }

    public func minusMonth(date: Date) -> Date? {
        return calendar.date(byAdding: .month, value: -1, to: date)
    }

    public func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date)
    }

    public func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }

    public func timeString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    public func daysInMonth(date: Date) -> Int? {
        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count
    }

    public func dayOfMonth(date: Date) -> Int? {
        let components = calendar.dateComponents([.day], from: date)
        return components.day
    }

    public func firstOfMonth(date: Date) -> Date? {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)
    }

    public func weekDay(date: Date) -> Int? {
        let components = calendar.dateComponents([.weekday], from: date)
        let weekday = components.weekday
        guard let weekday = weekday else { return 1}
        return weekday - 1
    }

    public func weekDayType(date: Date) -> MealPlannerWeekDays {
        switch weekDay(date: date) {
        case 0:
            return .sunday
        case 1:
            return .monday
        case 2:
            return .tuesday
        case 3:
            return .wednesday
        case 4:
            return .thursday
        case 5:
            return .friday
        case 6:
            return .saturday
        default:
            return .monday
        }
    }

    public func weekDayFromType(_ type: MealPlannerWeekDays, start: Date, end: Date) -> Date? {
        let dates = Date.dates(from: start, to: end)
        switch type {
        case .sunday:
            return dates[6]
        case .monday:
            return dates[0]
        case .tuesday:
            return dates[1]
        case .wednesday:
            return dates[2]
        case .thursday:
            return dates[3]
        case .friday:
            return dates[4]
        case .saturday:
            return dates[5]
        }
    }

    public func addDays(date: Date, days: Int) -> Date {
        return calendar.date(byAdding: .day, value: days, to: date) ?? Date()
    }

    public func mondayForDate(date: Date) -> Date {
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)

        while current > oneWeekAgo {
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            if currentWeekDay == 2 {
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }

}
