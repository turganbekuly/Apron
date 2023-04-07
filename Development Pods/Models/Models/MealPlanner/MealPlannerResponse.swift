//
//  MealPlannerResponse.swift
//  Models
//
//  Created by Akarys Turganbekuly on 11.02.2023.
//

import Foundation

public enum MealPlannerDayNamingTypes: String, Codable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}

public struct MealPlannerResponse: Codable {
    // MARK: - Coding Keys

    private enum CodingKeys: String, CodingKey {
        case day = "weekDay"
        case date, recipes
    }

    // MARK: - Properties

    public var day: MealPlannerDayNamingTypes?
    public var date: String?
    public var recipes: [RecipeResponse]?

    // MARK: - Init

    public init?(json: JSON) {
        self.day = MealPlannerDayNamingTypes(rawValue: json[CodingKeys.day.rawValue] as? String ?? "")
        self.date = json[CodingKeys.date.rawValue] as? String
        self.recipes = (json[CodingKeys.recipes.rawValue] as? [JSON])?.compactMap { RecipeResponse(json: $0) } ?? []
    }
}
